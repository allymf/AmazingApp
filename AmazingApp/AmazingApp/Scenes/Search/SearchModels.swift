//
//  SearchModels.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation
import AmazingNetwork

enum Search {
    
    enum SearchShow {
        
        struct Request {
            let name: String?
        }
        
        enum Response {
            struct Success {
                let searchShowResponse: [SearchShowResponse]
            }
            struct Failure {
                let error: NetworkLayerError
            }
        }
        
        enum ViewModel {
            struct Success {
                let showViewModels: [ShowCellModel]
            }
            struct Failure {
                let error: NetworkLayerError
            }
        }
        
    }
    
    enum SelectShow {
        struct Request {
            let index: Int
        }
    }
    
    struct Actions: SearchViewActions {
        let didSelectItemAt: (Int) -> Void
    }
    
    public struct ShowCellViewModel: ShowCellModel {
        let name: String
        let genresText: String
        let posterPath: String
        let ratingText: String
    }
    
}
