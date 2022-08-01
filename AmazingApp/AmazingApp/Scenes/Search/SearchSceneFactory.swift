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
        
        let viewController = SearchViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
