//
//  Episode.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

struct Episode: Decodable {
    let id: Int?
    let name: String?
    let number: Int?
    let season: Int?
    let summary: String?
    let image: ImagePath?
    let airdate: String?
    let airtime: String?
    let runtime: Int?
    let rating: Rating?
}
