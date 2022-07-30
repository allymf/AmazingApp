//
//  URLSession+DataTaskResult.swift
//
//
//  Created by Alysson on 30/07/22.
//

import Foundation

public protocol URLSessioning {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Result<(Data, URLResponse), Error>) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessioning {
    public func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Result<(Data, URLResponse), Error>) -> Void
    ) -> URLSessionDataTask {
        return dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let response = response else {
                completionHandler(.failure(NetworkLayerError.serverError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NetworkLayerError.noData))
                return
            }
            
            completionHandler(.success((data, response)))

        }
    }
}
