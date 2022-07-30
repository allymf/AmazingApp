//
//  Endpoint.swift
//
//
//  Created by Alysson on 30/07/22
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: String]? { get }
    var method: HTTPMethod { get }
}
