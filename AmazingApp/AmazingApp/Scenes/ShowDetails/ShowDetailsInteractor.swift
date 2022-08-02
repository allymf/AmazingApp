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
}

protocol ShowDetailsDataStore {
    var show: Show { get }
}

final class ShowDetailsInteractor: ShowDetailsBusinessLogic, ShowDetailsDataStore {
    
    private let presenter: ShowDetailsPresentationLogic
    private let episodeWorker: EpisodeRepositoryType
    
    public let show: Show
    
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
            switch result {
            case let .success(episodes):
                self?.presenter.presentShowSeasons(response: .init(episodes: episodes))
            case let .failure(error):
                self?.presenter.presentShowSeasonsFailure(response: .init(error: error))
            }
        }
    }
    
}
