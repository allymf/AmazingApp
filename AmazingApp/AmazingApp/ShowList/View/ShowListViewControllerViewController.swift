//
//  ShowListViewController.swift
//  AmazingApp
//
//  Created by Alysson on 30/07/22.
//
import UIKit

final class ShowListViewController: UIViewController {
    
    private let interactor: ShowListBusinessLogic
    
    init(interactor: ShowListBusinessLogic = ShowListInteractor()) {
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
        view = ShowListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchShows()
    }
    
}

