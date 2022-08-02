//
//  SearchPresenter.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

protocol SearchPresentationLogic {
    func presentShows(response: Search.SearchShow.Response.Success)
    func presentFailureShows(response: Search.SearchShow.Response.Failure)
    func presentSelectedShow()
}

final class SearchPresenter: SearchPresentationLogic {
  
    weak var viewController: SearchDisplayLogic?
    
    func presentShows(response: Search.SearchShow.Response.Success) {
        let showViewModels = response.searchShowResponse.map { self.makeShowCellViewModel(for: $0) }
        
        let viewModel = Search.SearchShow.ViewModel.Success(showViewModels: showViewModels)
        
           viewController?.displayShows(viewModel: viewModel)
    }
    
    func presentFailureShows(response: Search.SearchShow.Response.Failure) {
        viewController?.displayFailureShows(viewModel: .init(error: response.error))
    }
    
    private func makeShowCellViewModel(for searchShowResponse: SearchShowResponse) -> ShowCellModel {
        let genresText = searchShowResponse.show.genres?.joined(separator: ", ") ?? "Unknown"
        var rating = "-"
        if let showRating = searchShowResponse.show.rating?.average {
            rating = "\(showRating)"
        }
        
        return Search.ShowCellViewModel(
            name: searchShowResponse.show.name ?? "",
            genresText: genresText,
            posterPath: searchShowResponse.show.image?.medium ?? "",
            ratingText: " ⭑ \(rating) "
        )
    }
    
    func presentSelectedShow() {
        viewController?.displaySelectedShow()
    }
    
}
