//
//  ShowListViewController.swift
//  AmazingApp
//
//  Created by Alysson on 30/07/22.
//
import UIKit

final class ShowListViewController: UIViewController {
    
    // MARK: - Properties
    let viewProtocol: ShowListViewProtocol
    private let interactor: ShowListBusinessLogic
    let router: ShowListRoutingLogic
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(
        viewProtocol: ShowListViewProtocol = ShowListView(),
        interactor: ShowListBusinessLogic,
        router: ShowListRoutingLogic
    ) {
        self.viewProtocol = viewProtocol
        self.interactor = interactor
        self.router = router
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        viewProtocol.actions = ShowList.Actions(
            didSelectItemAt: didSelectItemAt,
            prefetchNextShowsPage: fetchNextPage
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = viewProtocol.concreteView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        viewProtocol.renderLoadingState()
        interactor.fetchShows()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Shows"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(didTapSearchButton)
        )
        navigationController?.extendedLayoutIncludesOpaqueBars = true
    }
    
    private func fetchNextPage(_ indexPaths: [IndexPath]) {
        interactor.fetchNextShowsPage(request: .init(indexPaths: indexPaths))
    }
    
    private func didSelectItemAt(_ index: Int) {
        interactor.selectShow(request: .init(index: index))
    }
    
    @objc func didTapSearchButton() {
        router.routeToSearch()
    }
}

