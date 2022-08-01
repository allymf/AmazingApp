//
//  EpisodeDetailsViewController.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

final class EpisodeDetailsViewController: UIViewController {
    
    let viewProtocol: EpisodeDetailsViewProtocol
    let interactor: EpisodeDetailsBusinessLogic
    
    init(
        viewProtocol: EpisodeDetailsViewProtocol = EpisodeDetailsView(),
        interactor: EpisodeDetailsBusinessLogic
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
        
        interactor.fetchEpisodeDetails()
    }
    
}
