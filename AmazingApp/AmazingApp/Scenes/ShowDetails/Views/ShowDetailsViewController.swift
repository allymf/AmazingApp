//
//  ShowDetailsViewController.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

final class ShowDetailsViewController: UIViewController {
    
    let viewProtocol: ShowDetailsViewProtocol
    private let interactor: ShowDetailsBusinessLogic
    
    init(
        viewProtocol: ShowDetailsViewProtocol = ShowDetailsView(),
        interactor: ShowDetailsBusinessLogic
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = nil
        navigationController?.navigationBar.prefersLargeTitles = false
        interactor.fetchShowDetail()
    }
    
}
