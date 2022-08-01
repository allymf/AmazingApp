//
//  ShowEndpoint.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import AmazingNetwork

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
