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
    
    struct ShowDetailHeaderViewModel {
        let iconPath: String
        let bannerPath: String
        let name: String
        let scheduleText: String
        let genresText: String
        let summary: String
    }
    
    struct SeasonViewModel {
        let seasonTitle: String
        let number: Int
        var episodes: [EpisodeViewModel]
    }
    
    struct EpisodeViewModel {
        let posterPath: String
        let name: String
        let number: String
        let season: Int
        let summary: String
    }
    
}
