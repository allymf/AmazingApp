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

enum ShowEndpoint: Endpoint {
    case allShows(page: Int)
    
    var baseURL: String { "https://api.tvmaze.com" }
    
    var path: String {
        switch self {
        case .allShows:
            return "/shows"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case let .allShows(page):
            return ["page": "\(page)"]
        }
    }
    
    var method: HTTPMethod { .get }
    
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
