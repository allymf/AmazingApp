//
//  ShowListModels.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation
import AmazingNetwork

enum ShowList {
    
    enum FetchShows {
        
        enum Response {
            struct Success {
                let shows: [Show]
            }
            struct Failure {
                let error: NetworkLayerError
            }
        }
        
    }
    
}
