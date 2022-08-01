//
//  ShowListSceneFactory.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

struct ShowListSceneFactory {
    static func makeScene() -> ShowListViewController {
        let presenter = ShowListPresenter()
        
        let interactor = ShowListInteractor(presenter: presenter)
        
        let router = ShowListRouter()
        
        let viewController = ShowListViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
