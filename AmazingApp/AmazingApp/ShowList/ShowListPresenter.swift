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
    
    weak var viewController: ShowListDisplayLogic?
    
    func presentShows(response: ShowList.FetchShows.Response.Success) {
        let showViewModels = response.shows.map { self.makeShowCellViewModel(for: $0) }
        
        let viewModel = ShowList.FetchShows.ViewModel.Success(showViewModels: showViewModels)
        viewController?.displayShows(viewModel: viewModel)
    }
    
    func presentFailureShows(response: ShowList.FetchShows.Response.Failure) {
        viewController?.displayFailureShows(viewModel: .init(error: response.error))
    }
    
    private func makeShowCellViewModel(for show: Show) -> ShowCollectionViewCell.ShowCellViewModel {
        let genresText = show.genres?.joined(separator: ", ") ?? "Unknown"
        
        return .init(
            name: show.name ?? "",
            genresText: genresText,
            posterPath: show.image?.medium ?? ""
        )
    }
    
}
