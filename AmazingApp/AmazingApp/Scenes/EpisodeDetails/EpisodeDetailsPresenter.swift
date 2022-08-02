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
        let seasonNumberText = makeSerieNumber(prefix: "Season", number: response.episode.season)
        let episodeNumberText = makeSerieNumber(prefix: "Episode", number: response.episode.number)
        let episodeViewModel = EpisodeDetails.EpisodeViewModel(
            bannerPath: response.episode.image?.original ?? "",
            name: response.episode.name ?? "",
            seasonNumberText: seasonNumberText,
            episodeNumberText: episodeNumberText,
            summary: response.episode.summary?.removeHTMLMarks() ?? ""
        )
        
        viewController?.displayEpisodeDetails(viewModel: .init(episodeViewModel: episodeViewModel))
    }
    
    private func makeSerieNumber(prefix: String, number: Int?) -> String {
        guard let number = number else {
            return "\(prefix) -"
        }
        return "\(prefix) \(number)"
    }
    
}
