//
//  ShowListInteractor.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

protocol ShowListBusinessLogic {
    func fetchShows()
}

final class ShowListInteracor: ShowListBusinessLogic {
    
    private let showWorker: ShowRepositoryType
    
    init(showWorker: ShowRepositoryType = ShowRepository()) {
        self.showWorker = showWorker
    }
    
    func fetchShows() {
        
    }
    
    
}
