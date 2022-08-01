//
//  ShowDetailsSceneFactory.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

struct ShowDetailsSceneFactory {
    static func makeScene(show: Show) -> ShowDetailsViewController {
        let presenter = ShowDetailsPresenter()
        let interactor = ShowDetailsInteractor(
            presenter: presenter,
            show: show
        )
        let router = ShowDetailsRouter(dataStore: interactor)
        let viewController = ShowDetailsViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
