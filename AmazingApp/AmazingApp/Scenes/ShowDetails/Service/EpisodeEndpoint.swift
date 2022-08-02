//
//  EpisodeEndpoint.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation
import AmazingNetwork

enum EpisodeEndpoint: Endpoint {
    case allEpisodes(showId: Int)
    
    var baseURL: String { "https://api.tvmaze.com/" }
    
    var path: String {
        switch self {
        case let .allEpisodes(showId):
            return "/shows/\(showId)/episodes"
        }
    }
    
    var parameters: [String : String]? { nil }
    
    var method: HTTPMethod { .get }
    
}
