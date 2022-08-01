//
//  EpisodeDetailsInteractor.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol EpisodeDetailsBusinessLogic {
    func fetchEpisodeDetails()
}

final class EpisodeDetailsInteractor: EpisodeDetailsBusinessLogic {
    
    private let presenter: EpisodeDetailsPresentationLogic
    private let episode: Episode
    
    init(
        presenter: EpisodeDetailsPresentationLogic,
        episode: Episode
    ) {
        self.presenter = presenter
        self.episode = episode
    }
    
    func fetchEpisodeDetails() {
        presenter.presentEpisodeDetails(response: .init(episode: episode))
    }
    
}
