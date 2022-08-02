//
//  ShowDetailsRouter.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol ShowDetailsRoutingLogic {
    func routeToEpisodeDetails()
}

final class ShowDetailsRouter: ShowDetailsRoutingLogic {
    
    weak var viewController: ShowDetailsViewController?
    private var dataStore: ShowDetailsDataStore
    
    init(dataStore: ShowDetailsDataStore) {
        self.dataStore = dataStore
    }
    
    func routeToEpisodeDetails() {
        guard let selectedEpisode = dataStore.selectedEpisode else { return }
        
        let episodeDetailsViewController = EpisodeDetailsSceneFactory.makeScene(episode: selectedEpisode)
        viewController?.navigationController?.pushViewController(
            episodeDetailsViewController,
            animated: true
        )
    }
    
}
