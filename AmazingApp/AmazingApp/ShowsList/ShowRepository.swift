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

struct Show: Decodable {
    
    let id: Int?
    let name: String?
    let genres: [String]?
    let schedule: Schedule?
    let summary: String?
    let image: ImagePath?
    
    struct Schedule: Decodable {
        let time: String?
        let days: [Day]
        
        enum Day: String, Decodable {
            case monday = "Monday",
                tuesday = "Tuesday",
                wednesday = "Wednesday",
                thursday = "Thursday",
                friday = "Friday",
                saturday = "Saturday",
                sunday = "Sunday"
        }
    }
    
    struct ImagePath: Decodable {
        let medium: String?
    }
    
    struct Rating: Decodable {
        let average: Double?
    }
    
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
