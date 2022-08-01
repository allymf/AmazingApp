//
//  ShowListViewController.swift
//  AmazingApp
//
//  Created by Alysson on 30/07/22.
//
import UIKit

final class ShowListViewController: UIViewController {
    
    let viewProtocol: ShowListViewProtocol
    private let interactor: ShowListBusinessLogic
    
    init(
        viewProtocol: ShowListViewProtocol = ShowListView(),
        interactor: ShowListBusinessLogic
    ) {
        self.viewProtocol = viewProtocol
        self.interactor = interactor
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        viewProtocol.actions = ShowList.Actions(prefetchNextShowsPage: fetchNextPage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = viewProtocol.concreteView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewProtocol.renderLoadingState()
        interactor.fetchShows()
    }
    
    private func fetchNextPage(_ indexPaths: [IndexPath]) {
        interactor.fetchNextShowsPage(request: .init(indexPaths: indexPaths))
    }
    
}

