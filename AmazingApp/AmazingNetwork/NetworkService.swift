//
//  NetworkService.swift
//
//
//  Created by Alysson on 30/07/22.
//

import Foundation

public enum NetworkLayerError: Error {
    case unableToCreateURL
    case unableToCreateRequest
    case noData
    case serverError
    case invalidResponseTyp
}

public protocol HTTPClient {
    func request<Response: Decodable>(
        endpoint: Endpoint,
        responseType: Response.Type,
        completionHandler: @escaping (Result<(Response), Error>) -> Void
    )
}

public final class NetworkService: HTTPClient {
    
    private let requestBuilder: RequestBuilding
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(
        requestBuilder: RequestBuilding = RequestBuilder(),
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.requestBuilder = requestBuilder
        self.session = session
        self.decoder = decoder
    }
    
    public func request<Response: Decodable>(
        endpoint: Endpoint,
        responseType: Response.Type,
        completionHandler: @escaping (Result<(Response), Error>) -> Void
    ) {
        do {
            let request = try requestBuilder.buildRequest(for: endpoint)
            
            session.dataTask(with: request) { response in
                let result = self.handleRequestResponse(response)
                
                switch result {
                case let .failure(error):
                    completionHandler(.failure(error))
                    
                case let .success(data):
                    do {
                        let response = try self.decoder.decode(
                            responseType,
                            from: data
                        )
                        completionHandler(.success(response))
                    } catch {
                        completionHandler(.failure(error))
                    }
                    
                }
            }
            
        } catch {
            completionHandler(.failure(error))
        }
        
    }
    
    private func handleRequestResponse(_ response: Result<(Data, URLResponse), Error>) -> Result<Data, Error> {
        switch response {
        case let .failure(error):
            return .failure(error)
        case let .success((data, response)):
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkLayerError.serverError)
            }
            
            return handleHTTPRequestResponse(httpResponse, data: data)
        }
    }
    
    private func handleHTTPRequestResponse(_ response: HTTPURLResponse, data: Data) -> Result<Data, Error> {
        switch response.statusCode {
        case 200...299:
            return .success(data)
        default:
            return .failure(NetworkLayerError.serverError)
        }
    }
    
}
