//
//  ShowListInteractor.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

protocol ShowListBusinessLogic {
    func fetchShows()
}

final class ShowListInteractor: ShowListBusinessLogic {
    
    private let presenter: ShowListPresentationLogic
    private let showWorker: ShowRepositoryType
    private var currentShowListPage = 0
    
    init(
        presenter: ShowListPresentationLogic = ShowListPresenter(),
        showWorker: ShowRepositoryType = ShowRepository()
    ) {
        self.presenter = presenter
        self.showWorker = showWorker
    }
    
    func fetchShows() {
        currentShowListPage += 1
        
        showWorker.fetchShows(page: currentShowListPage) { [weak self] result in
            switch result {
            case let .success(shows):
                let response = ShowList.FetchShows.Response.Success(shows: shows)
                self?.presenter.presentShows(response: response)
            case let .failure(error):
                let response = ShowList.FetchShows.Response.Failure(error: error)
                self?.presenter.presentFailureShows(response: response)
            }
        }
        
    }
    
    
}
