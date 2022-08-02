//
//  SearchViewController+DisplayLogic.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

protocol SearchDisplayLogic: AnyObject {
    func displayShows(viewModel: Search.SearchShow.ViewModel.Success)
    func displayFailureShows(viewModel: Search.SearchShow.ViewModel.Failure)
    func displaySelectedShow()
}

extension SearchViewController: SearchDisplayLogic {
    
    func displayShows(viewModel: Search.SearchShow.ViewModel.Success) {
        DispatchQueue.main.async {
            self.viewProtocol.updateShowViewModels(viewModel.showViewModels)
        }
    }
    func displayFailureShows(viewModel: Search.SearchShow.ViewModel.Failure) {}
    
    func displaySelectedShow() {
        router.routeToShowDetails()
    }
}
