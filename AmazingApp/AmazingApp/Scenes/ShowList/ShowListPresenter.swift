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
    func presentNextShowsPage(response: ShowList.FetchShows.Response.Success)
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
    
    func presentNextShowsPage(response: ShowList.FetchShows.Response.Success) {
        let showViewModels = response.shows.map { self.makeShowCellViewModel(for: $0) }
        
        viewController?.displayNextShowsPage(viewModel: .init(showViewModels: showViewModels))
    }
    
    
    private func makeShowCellViewModel(for show: Show) -> ShowCellModel {
        let genresText = show.genres?.joined(separator: ", ") ?? "Unknown"
        var rating = "-"
        if let showRating = show.rating?.average {
            rating = "\(showRating)"
        }
        
        return ShowList.ShowCellViewModel(
            name: show.name ?? "",
            genresText: genresText,
            posterPath: show.image?.medium ?? "",
            ratingText: " ⭑ \(rating) "
        )
    }

}
