//
//  Show.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

struct Show: Decodable {
    
    let id: Int?
    let name: String?
    let genres: [String]?
    let schedule: Schedule?
    let summary: String?
    let image: ImagePath?
    let rating: Rating?
    
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
