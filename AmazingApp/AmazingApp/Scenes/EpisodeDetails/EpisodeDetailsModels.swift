//
//  EpisodeDetailsModels.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

enum EpisodeDetails {
    
    enum FetchEpisodeDetails {
        enum Response {
            struct Success {
                let episode: Episode
            }
        }
        enum ViewModel {
            struct Success {
                let episodeViewModel: EpisodeViewModel
            }
        }
    }
    
    struct EpisodeViewModel: EntityDetailsViewModel {
        
        var iconPath: String { "" }
        var subtitle: String { seasonNumberText }
        var headline: String { episodeNumberText }
        
        let bannerPath: String
        let name: String
        let seasonNumberText: String
        let episodeNumberText: String
        let summary: String
    }
    
}
