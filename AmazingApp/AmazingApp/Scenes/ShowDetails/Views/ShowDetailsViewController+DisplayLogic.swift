//
//  ShowDetailsViewController+DisplayLogic.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol ShowDetailsDisplayLogic: AnyObject {
    func displayShowDetails(viewModel: ShowDetails.FetchShowDetail.ViewModel.Success)
    func displayShowSeasons(viewModel: ShowDetails.FetchShowSeasons.ViewModel.Success)
    func displayShowSeasonsFailure(viewModel: ShowDetails.FetchShowSeasons.ViewModel.Failure)
}

extension ShowDetailsViewController: ShowDetailsDisplayLogic {
    func displayShowDetails(viewModel: ShowDetails.FetchShowDetail.ViewModel.Success) {
        viewProtocol.showDetailsHeaderViewModel = viewModel.headerViewModel
    }
    
    func displayShowSeasons(viewModel: ShowDetails.FetchShowSeasons.ViewModel.Success) {
        DispatchQueue.main.async {
            self.viewProtocol.seasonViewModels = viewModel.seasonViewModels
        }
    }
    
    func displayShowSeasonsFailure(viewModel: ShowDetails.FetchShowSeasons.ViewModel.Failure) {}
    
}
