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
                let seasons: [Season]
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
    
    enum SelectEpisode {
        struct Request {
            let indexPath: IndexPath
        }
    }
    
    struct Actions: ShowDetailsViewActions {
        let didSelectRowAt: (IndexPath) -> Void
    }
    
    struct ShowDetailHeaderViewModel: EntityDetailsViewModel {
        let iconPath: String
        let bannerPath: String
        let name: String
        let subtitle: String
        let headline: String
        let summary: String
    }
    
    struct Season {
        let number: Int
        var episodes: [Episode]
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
