//
//  ShowListPresenter.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

protocol ShowListPresentationLogic {
    func presentShows(response: ShowList.FetchShows.Response.Success)
    func presentFailureShows(response: ShowList.FetchShows.Response.Failure)
}

final class ShowListPresenter: ShowListPresentationLogic {
    
    weak var viewController: ShowListViewController?
    
    func presentShows(response: ShowList.FetchShows.Response.Success) {
        
    }
    
    func presentFailureShows(response: ShowList.FetchShows.Response.Failure) {
        
    }
    
    
}
