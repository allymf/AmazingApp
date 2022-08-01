//
//  ShowListViewController+DisplayLogic.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

protocol ShowListDisplayLogic: AnyObject {
    func displayShows(viewModel: ShowList.FetchShows.ViewModel.Success)
    func displayFailureShows(viewModel: ShowList.FetchShows.ViewModel.Failure)
    func displayNextShowsPage(viewModel: ShowList.FetchShows.ViewModel.Success)
    func displaySelectedShow()
}

extension ShowListViewController: ShowListDisplayLogic {
    
    func displayShows(viewModel: ShowList.FetchShows.ViewModel.Success) {
        DispatchQueue.main.async {
            self.viewProtocol.updateShowViewModels(viewModel.showViewModels)
        }
    }
    func displayFailureShows(viewModel: ShowList.FetchShows.ViewModel.Failure) {}
    
    func displayNextShowsPage(viewModel: ShowList.FetchShows.ViewModel.Success) {
        DispatchQueue.main.async {
            self.viewProtocol.insertShowViewModels(viewModel.showViewModels)
        }
    }
    
    func displaySelectedShow() {
        router.routeToShowDetails()
    }
    
}
