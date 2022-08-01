//
//  ShowListRouter.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

protocol ShowListRoutingLogic {
    func routeToSearch()
}

final class ShowListRouter: ShowListRoutingLogic {
    weak var viewController: UIViewController?
    
    func routeToSearch() {
        let searchViewController = SearchSceneFactory.makeScene()
        
        viewController?.navigationController?.pushViewController(searchViewController, animated: true)
    }
}
