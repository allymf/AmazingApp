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
    let router: ShowDetailsRoutingLogic
    
    init(
        viewProtocol: ShowDetailsViewProtocol = ShowDetailsView(),
        interactor: ShowDetailsBusinessLogic,
        router: ShowDetailsRoutingLogic
    ) {
        self.viewProtocol = viewProtocol
        self.interactor = interactor
        self.router = router
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        viewProtocol.actions = ShowDetails.Actions(didSelectRowAt: didSelectRowAt)
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
    
    private func didSelectRowAt(_ indexPath: IndexPath) {
        interactor.selectEpisode(request: .init(indexPath: indexPath))
    }
    
}
