//
//  ShowDetailsModels.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation
import AmazingNetwork

enum ShowDetails {
    
    enum FetchShowDetail {
        enum Response {
            struct Success {
                let show: Show
            }
        }
        
        enum ViewModel {
            struct Success {
                let headerViewModel: ShowDetailHeaderViewModel
            }
        }
    }
    
    enum FetchShowSeasons {
        enum Response {
            struct Success {
                let episodes: [Episode]
            }
            struct Failure {
                let error: NetworkLayerError
            }
        }
        
        enum ViewModel {
            struct Success {
                let seasonViewModels: [SeasonViewModel]
            }
            
            struct Failure {
                let error: NetworkLayerError
            }
        }
    }
    
    struct ShowDetailHeaderViewModel: EntityDetailsViewModel {
        let iconPath: String
        let bannerPath: String
        let name: String
        let timeText: String
        let genresText: String
        let summary: String
    }
    
    struct SeasonViewModel {
        let seasonTitle: String
        let number: Int
        var episodes: [EpisodeViewModel]
    }
    
    struct EpisodeViewModel: EntityCellViewModel {
        let posterPath: String
        let name: String
        let rating: String
        let season: Int
        
        // MARK: - Entity Interface
        var imagePath: String { posterPath }
        var title: String { name }
        var description: String { rating }
    }
    
}
