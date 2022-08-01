//
//  ShowDetailsViewController+DisplayLogic.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol ShowDetailsDisplayLogic: AnyObject {
    func displayShowDetails(viewModel: ShowDetails.FetchShowDetail.ViewModel.Success)
}

extension ShowDetailsViewController: ShowDetailsDisplayLogic {
    func displayShowDetails(viewModel: ShowDetails.FetchShowDetail.ViewModel.Success) {
        
    }
}
