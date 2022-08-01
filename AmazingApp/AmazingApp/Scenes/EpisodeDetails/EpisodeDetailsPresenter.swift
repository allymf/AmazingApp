//
//  EpisodeDetailsPresenter.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol EpisodeDetailsPresentationLogic {
    func presentEpisodeDetails(response: EpisodeDetails.FetchEpisodeDetails.Response.Success)
}

final class EpisodeDetailsPresenter: EpisodeDetailsPresentationLogic {
    weak var viewController: EpisodeDetailsDisplayLogic?
    
    func presentEpisodeDetails(response: EpisodeDetails.FetchEpisodeDetails.Response.Success) {
        let episodeViewModel = EpisodeDetails.EpisodeViewModel(
            posterPath: response.episode.image?.original ?? "",
            name: response.episode.name ?? "",
            seasonAndEpisodeNumberText: makeSeasonAndEpisodeNumberText(from: response.episode),
            summary: response.episode.summary?.removeHTMLMarks() ?? ""
        )
        
        viewController?.displayEpisodeDetails(viewModel: .init(episodeViewModel: episodeViewModel))
    }
    
    private func makeSeasonAndEpisodeNumberText(from episode: Episode) -> String {
        var seasonText = ""
        var episodeText = ""
        
        if let seasonNumber = episode.season {
            seasonText = "S\(seasonNumber)"
        }
        
        if let episodeNumber = episode.number {
            episodeText = "E\(episodeNumber)"
        }
        
        return seasonText + episodeText
    }
    
    
}
