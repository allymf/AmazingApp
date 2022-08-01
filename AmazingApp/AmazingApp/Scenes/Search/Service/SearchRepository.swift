//
//  SearchRepository.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation
import AmazingNetwork

protocol SearchRepositoryType {
    func searchShow(
        by name: String,
        completionHandler: @escaping (Result<[SearchShowResponse], NetworkLayerError>) -> Void
    )
    
    func cancelCurrentRequest()
}

final class SearchRepository: SearchRepositoryType {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = NetworkService()) {
        self.httpClient = httpClient
    }
    
    func searchShow(
        by name: String,
        completionHandler: @escaping (Result<[SearchShowResponse], NetworkLayerError>) -> Void
    ) {
        httpClient.request(
            endpoint: SearchEndpoint.searchShow(byName: name),
            responseType: [SearchShowResponse].self,
            completionHandler: completionHandler
        )
    }
    
    func cancelCurrentRequest() {
        httpClient.cancelCurrentTask()
    }
    
}
