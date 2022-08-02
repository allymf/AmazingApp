//
//  SearchRouter.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

protocol SearchRoutingLogic {
    func routeToShowDetails()
}

final class SearchRouter: SearchRoutingLogic {
    weak var viewController: SearchViewController?
    private let dataStore: SearchDataStore
    
    init(dataStore: SearchDataStore) {
        self.dataStore = dataStore
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
