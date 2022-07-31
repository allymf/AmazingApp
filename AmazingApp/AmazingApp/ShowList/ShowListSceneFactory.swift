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
        
        let viewController = ShowListViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
