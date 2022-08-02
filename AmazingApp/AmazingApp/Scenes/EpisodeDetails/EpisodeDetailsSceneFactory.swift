//
//  EpisodeDetailsSceneFactory.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

struct EpisodeDetailsSceneFactory {
    static func makeScene(episode: Episode) -> EpisodeDetailsViewController {
        let presenter = EpisodeDetailsPresenter()
        let interactor = EpisodeDetailsInteractor(
            presenter: presenter,
            episode: episode
        )
        let viewController = EpisodeDetailsViewController(interactor: interactor)
        presenter.viewController = viewController
        
        return viewController
    }
}
