//
//  ShowCellPresenter.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation
import UIKit

protocol AmazingImageViewPresentationLogic {
    func presentLoadingState()
    func presentImage(response: AmazingImageViewModels.FetchImage.Response.Success)
    func presentImageFailure(response: AmazingImageViewModels.FetchImage.Response.Failure)
}

final class AmazingImageViewPresenter: AmazingImageViewPresentationLogic {
    
    weak var view: AmazingImageViewDisplayLogic?
    
    func presentLoadingState() {
        view?.displayLoadingState()
    }
    
    func presentImage(response: AmazingImageViewModels.FetchImage.Response.Success) {
        let image = UIImage(data: response.data) ?? UIImage()
        view?.displayImage(viewModel: .init(image: image))
    }
    
    func presentImageFailure(response: AmazingImageViewModels.FetchImage.Response.Failure) {
        view?.displayImageFailure(viewModel: .init(error: response.error))
    }
}
