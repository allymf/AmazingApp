//
//  HTTPMethod.swift
//
//
//  Created by Alysson on 30/07/22.
//

import Foundation

public enum HTTPMethod: String {
    case get,
        post
    
    var value: String { rawValue.uppercased() }
}
