//
//  SearchInteractor.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

protocol SearchBusinessLogic {
    func searchShowByName(request: Search.SearchShow.Request)
    func selectShow(request: Search.SelectShow.Request)
}

protocol SearchDataStore {
    var selectedShow: Show? { get }
}

final class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    
    private let presenter: SearchPresentationLogic
    private let searchWorker: SearchRepositoryType
    private var shows: [Show] = []
    private(set) var selectedShow: Show?
    
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
                self.shows = searchResponse.map { $0.show }
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
    
    func selectShow(request: Search.SelectShow.Request) {
        selectedShow = shows[safeIndex: request.index]
        presenter.presentSelectedShow()
    }
    
}
