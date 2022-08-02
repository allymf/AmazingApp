//
//  EpisodeRepository.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation
import AmazingNetwork

protocol EpisodeRepositoryType {
    func fetchAllEpisodes(
        showId: Int,
        completionHandler: @escaping (Result<[Episode], NetworkLayerError>) -> Void
    )
    
    func cancelCurrentRequest()
}

final class EpisodeRepository: EpisodeRepositoryType {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = NetworkService()) {
        self.httpClient = httpClient
    }
    
    func fetchAllEpisodes(
        showId: Int,
        completionHandler: @escaping (Result<[Episode], NetworkLayerError>) -> Void
    ) {
        httpClient.request(
            endpoint: EpisodeEndpoint.allEpisodes(showId: showId),
            responseType: [Episode].self,
            completionHandler: completionHandler
        )
    }
    
    func cancelCurrentRequest() {
        httpClient.cancelCurrentTask()
    }
    
}
