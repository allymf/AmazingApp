//
//  ShowCellModels.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation
import UIKit

enum AmazingImageViewModels {
    
    enum FetchImage {
        struct Request {
            let path: String
        }
        
        enum Response {
            struct Success {
                let data: Data
            }
            struct Failure {
                let error: Error
            }
        }
        
        enum ViewModel {
            struct Success {
                let image: UIImage
            }
            struct Failure {
                let error: Error
            }
        }
    }
    
}
