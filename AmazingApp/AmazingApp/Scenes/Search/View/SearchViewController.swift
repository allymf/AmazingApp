//
//  SearchViewController.swift
//  AmazingApp
//
//  Created by Alysson on 30/07/22.
//
import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    let viewProtocol: SearchViewProtocol
    private let interactor: SearchBusinessLogic
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(
        viewProtocol: SearchViewProtocol = SearchView(),
        interactor: SearchBusinessLogic
    ) {
        self.viewProtocol = viewProtocol
        self.interactor = interactor
        
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = viewProtocol.concreteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        
        configureSearchController()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Tv Shows"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
      viewProtocol.renderLoadingState()
      interactor.searchShowByName(request: .init(name: searchBar.text))
  }
}
