//
//  ShowListRouter.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

protocol ShowListRoutingLogic {
    func routeToSearch()
    func routeToShowDetails()
}

final class ShowListRouter: ShowListRoutingLogic {
    weak var viewController: ShowListViewController?
    private let dataStore: ShowListDataStore
    
    init(dataStore: ShowListDataStore) {
        self.dataStore = dataStore
    }
    
    func routeToSearch() {
        let searchViewController = SearchSceneFactory.makeScene()
        
        viewController?.navigationController?.pushViewController(
            searchViewController,
            animated: true
        )
    }
    
    func routeToShowDetails() {
        guard let selectedShow = dataStore.selectedShow else {
            return
        }
        let showDetailsViewController = ShowDetailsSceneFactory.makeScene(show: selectedShow)
        
        viewController?.navigationController?.pushViewController(
            showDetailsViewController,
            animated: true
        )
    }
    
}
