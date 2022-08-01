//
//  ShowDetailsInteractor.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

protocol ShowDetailsBusinessLogic {}

protocol ShowDetailsDataStore {
    var show: Show { get }
}

final class ShowDetailsInteractor: ShowDetailsBusinessLogic, ShowDetailsDataStore {
    
    private let presenter: ShowDetailsPresentationLogic
    
    public let show: Show
    
    init(
        presenter: ShowDetailsPresentationLogic,
        show: Show
    ) {
        self.presenter = presenter
        self.show = show
    }
    
}
