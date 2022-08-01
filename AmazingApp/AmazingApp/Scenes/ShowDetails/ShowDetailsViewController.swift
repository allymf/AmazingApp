//
//  ShowDetailsViewController.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

final class ShowDetailsViewController: UIViewController {
    
    private let interactor: ShowDetailsBusinessLogic
    
    init(interactor: ShowDetailsBusinessLogic) {
        self.interactor = interactor
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
