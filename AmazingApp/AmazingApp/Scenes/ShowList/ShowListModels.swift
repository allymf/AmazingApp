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
        
        enum ViewModel {
            struct Success {
                let showViewModels: [ShowCellModel]
            }
            struct Failure {
                let error: NetworkLayerError
            }
        }
        
    }
    
    enum FetchNextPage {
        struct Request {
            let indexPaths: [IndexPath]
        }
    }
    
    public struct Actions: ShowListViewActions {
        let prefetchNextShowsPage: ([IndexPath]) -> Void
    }
    
    public struct ShowCellViewModel: ShowCellModel {
        let name: String
        let genresText: String
        let posterPath: String
        let ratingText: String
    }
    
}
