//
//  SearchEndpoint.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import AmazingNetwork

enum SearchEndpoint: Endpoint {
    case searchShow(byName: String)
    
    var baseURL: String { "https://api.tvmaze.com" }
    
    var path: String {
        switch self {
        case .searchShow:
            return "/search/shows"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case let .searchShow(name):
            return ["q": name]
        }
    }
    
    var method: HTTPMethod { .get }
    
}
