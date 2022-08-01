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
    
    struct EpisodeViewModel: EpisodeDetailsViewModel {
        let posterPath: String
        let name: String
        let seasonAndEpisodeNumberText: String
        let summary: String
    }
    
}
