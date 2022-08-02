//
//  SearchSceneFactory.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

struct SearchSceneFactory {
    static func makeScene() -> SearchViewController {
        let presenter = SearchPresenter()
        
        let interactor = SearchInteractor(presenter: presenter)
        let router = SearchRouter(dataStore: interactor)
        
        let viewController = SearchViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
