//
//  ShowDetailsInteractor.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol ShowDetailsBusinessLogic {
    func fetchShowDetail()
    func fetchShowSeasons()
    func selectEpisode(request: ShowDetails.SelectEpisode.Request)
}

protocol ShowDetailsDataStore {
    var selectedEpisode: Episode? { get }
}

final class ShowDetailsInteractor: ShowDetailsBusinessLogic, ShowDetailsDataStore {
    
    private let presenter: ShowDetailsPresentationLogic
    private let episodeWorker: EpisodeRepositoryType
    
    private let show: Show
    private var seasons: [ShowDetails.Season] = []
    private(set) var selectedEpisode: Episode?
    
    init(
        presenter: ShowDetailsPresentationLogic,
        episodeWorker: EpisodeRepositoryType = EpisodeRepository(),
        show: Show
    ) {
        self.presenter = presenter
        self.episodeWorker = episodeWorker
        self.show = show
    }
    
    func fetchShowDetail() {
        presenter.presentShowDetails(response: .init(show: show))
        
        fetchShowSeasons()
    }
    
    func fetchShowSeasons() {
        guard let showId = show.id else {
            return
        }
        
        episodeWorker.cancelCurrentRequest()
        episodeWorker.fetchAllEpisodes(showId: showId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(episodes):
                self.seasons = self.makeSeasons(with: episodes)
                self.presenter.presentShowSeasons(response: .init(seasons: self.seasons))
            case let .failure(error):
                self.presenter.presentShowSeasonsFailure(response: .init(error: error))
            }
        }
    }
    
    func selectEpisode(request: ShowDetails.SelectEpisode.Request) {
        selectedEpisode = seasons[safeIndex: request.indexPath.section]?.episodes[safeIndex: request.indexPath.row]
        
        presenter.presentSelectedEpisode()
    }
    
    private func makeSeasons(with episodes: [Episode]) -> [ShowDetails.Season] {
        
        let seasons: [ShowDetails.Season] = episodes.reduce([]) { partialResult, episode in
            guard let currentEpisodeSeasonNumber = episode.season else { return partialResult }
            guard let existingSeasonIndex = partialResult.firstIndex(where: { $0.number == currentEpisodeSeasonNumber }) else {
                let newSeasonViewModel = ShowDetails.Season(
                    number: currentEpisodeSeasonNumber,
                    episodes: [episode]
                )
                return partialResult + [newSeasonViewModel]
            }
            
            var newResult = partialResult
            
            newResult[existingSeasonIndex].episodes.append(episode)
            return newResult
        }
        
        return seasons
    }
    
}
