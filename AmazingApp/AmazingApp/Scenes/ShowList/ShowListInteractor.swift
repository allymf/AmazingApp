//
//  ShowListInteractor.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

protocol ShowListBusinessLogic {
    func fetchShows()
    func fetchNextShowsPage(request: ShowList.FetchNextPage.Request)
    func selectShow(request: ShowList.SelectShow.Request)
}

protocol ShowListDataStore {
    var selectedShow: Show? { get }
}

final class ShowListInteractor: ShowListBusinessLogic, ShowListDataStore {
    
    private let presenter: ShowListPresentationLogic
    private let showWorker: ShowRepositoryType
    private var currentShowListPage = 1
    private var isFetchingData = false
    private var notOnLastPage = false
    
    private var shows: [Show] = []
    private(set) var selectedShow: Show?
    
    init(
        presenter: ShowListPresentationLogic,
        showWorker: ShowRepositoryType = ShowRepository()
    ) {
        self.presenter = presenter
        self.showWorker = showWorker
    }
    
    func fetchShows() {
        guard !isFetchingData else { return }
        
        showWorker.fetchShows(page: currentShowListPage) { [weak self] result in
            guard let self = self else { return }
            self.isFetchingData = false
            switch result {
            case let .success(shows):
                self.shows.append(contentsOf: shows)
                self.notOnLastPage = !shows.isEmpty
                
                guard self.currentShowListPage > 1 else {
                    self.successFirstPage(response: .init(shows: shows))
                    return
                }
                
                self.successNextPage(response: .init(shows: shows))
                
            case let .failure(error):
                let response = ShowList.FetchShows.Response.Failure(error: error)
                self.presenter.presentFailureShows(response: response)
            }
        }
        
        self.isFetchingData = true
    }
    
    func fetchNextShowsPage(request: ShowList.FetchNextPage.Request) {
        guard notOnLastPage, !isFetchingData, shouldFetchNextPage(for: request.indexPaths) else { return }
        currentShowListPage += 1
        fetchShows()
    }
    
    func selectShow(request: ShowList.SelectShow.Request) {
        selectedShow = shows[safeIndex: request.index]
        presenter.presentSelectedShow()
    }
    
    private func shouldFetchNextPage(for indexPaths: [IndexPath]) -> Bool {
        let prefetchThreshold = shows.count - 10
        
        guard let firstIndex = indexPaths.first?.item,
              firstIndex >= prefetchThreshold else { return false }
        
        return firstIndex >= prefetchThreshold
    }
    
    private func successFirstPage(response: ShowList.FetchShows.Response.Success) {
        presenter.presentShows(response: response)
    }
    
    private func successNextPage(response: ShowList.FetchShows.Response.Success) {
        presenter.presentNextShowsPage(response: response)
    }
    
}
