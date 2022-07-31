//
//  ShowRepository.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation
import AmazingNetwork

protocol ShowRepositoryType {
    func fetchShows(
        page: Int,
        completionHandler: @escaping (Result<[Show], NetworkLayerError>) -> Void
    )
}

final class ShowRepository: ShowRepositoryType {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = NetworkService()) {
        self.httpClient = httpClient
    }
    
    func fetchShows(
        page: Int,
        completionHandler: @escaping (Result<[Show], NetworkLayerError>) -> Void
    ) {
        httpClient.request(
            endpoint: ShowEndpoint.allShows(page: page),
            responseType: [Show].self,
            completionHandler: completionHandler
        )
    }
    
    
}
