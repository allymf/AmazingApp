//
//  SearchInteractor.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

protocol SearchBusinessLogic {
    func searchShowByName(request: Search.SearchShow.Request)
}

final class SearchInteractor: SearchBusinessLogic {
    
    private let presenter: SearchPresentationLogic
    private let searchWorker: SearchRepositoryType
    
    init(
        presenter: SearchPresentationLogic,
        searchWorker: SearchRepositoryType = SearchRepository()
    ) {
        self.presenter = presenter
        self.searchWorker = searchWorker
    }
    
    func searchShowByName(request: Search.SearchShow.Request) {
        searchWorker.searchShow(by: request.name ?? "") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(searchResponse):
                self.successSearch(response: .init(searchShowResponse: searchResponse))
            case let .failure(error):
                let response = Search.SearchShow.Response.Failure(error: error)
                self.presenter.presentFailureShows(response: response)
            }
        }
    }
    
    private func successSearch(response: Search.SearchShow.Response.Success) {
        presenter.presentShows(response: response)
    }
}
