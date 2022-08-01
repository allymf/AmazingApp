//
//  ShowCellInteractor.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation
import AmazingNetwork

protocol AmazingImageViewBusinessLogic {
    func fetchImage(request: AmazingImageViewModels.FetchImage.Request)
    func cancelImageFetch()
}

final class AmazingImageViewInteractor: AmazingImageViewBusinessLogic {
    
    private let presenter: AmazingImageViewPresentationLogic
    private let httpClient: HTTPClient
    
    init(
        presenter: AmazingImageViewPresentationLogic = AmazingImageViewPresenter(),
        httpClient: HTTPClient = NetworkService()
    ) {
        self.presenter = presenter
        self.httpClient = httpClient
    }
    
    func fetchImage(request: AmazingImageViewModels.FetchImage.Request) {
        self.presenter.presentLoadingState()
        httpClient.request(absolutePath: request.path) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.presenter.presentImageFailure(response: .init(error: error))
            case let .success(data):
                self?.presenter.presentImage(response: .init(data: data))
            }
        }
    }
    
    func cancelImageFetch() {
        httpClient.cancelCurrentTask()
    }
    
}
