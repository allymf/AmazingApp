//
//  AmazingImageView.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import UIKit

struct AmazingImageViewBuilder {
    static func makeView(frame: CGRect = .zero) -> AmazingImageView {
        let presenter = AmazingImageViewPresenter()
        let interactor = AmazingImageViewInteractor(presenter: presenter)
        let view = AmazingImageView(
            frame: frame,
            interactor: interactor
        )
        presenter.view = view
        
        return view
    }
}

final class AmazingImageView: UIImageView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.style = .medium
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()

    private let interactor: AmazingImageViewBusinessLogic
    
    public var imagePath = String() {
        didSet {
            interactor.fetchImage(request: .init(path: imagePath))
        }
    }
    
    init(
        image: UIImage?,
        interactor: AmazingImageViewBusinessLogic = AmazingImageViewInteractor()
    ) {
        self.interactor = interactor
        super.init(image: image)
    }
    
    init(
        frame: CGRect = .zero,
        interactor: AmazingImageViewBusinessLogic = AmazingImageViewInteractor()
    ) {
        self.interactor = interactor
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        configureActivityIndicator()
    }
    
    private func configureActivityIndicator() {
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate(
            [
                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }
    
    public func cancelImageFetch() {
        activityIndicator.stopAnimating()
        interactor.cancelImageFetch()
    }
    
}

protocol AmazingImageViewDisplayLogic: AnyObject {
    func displayLoadingState()
    func displayImage(viewModel: AmazingImageViewModels.FetchImage.ViewModel.Success)
    func displayImageFailure(viewModel: AmazingImageViewModels.FetchImage.ViewModel.Failure)
}

extension AmazingImageView: AmazingImageViewDisplayLogic {
    func displayLoadingState() {
        activityIndicator.startAnimating()
    }
    
    func displayImage(viewModel: AmazingImageViewModels.FetchImage.ViewModel.Success) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.image = viewModel.image
        }
    }
    
    func displayImageFailure(viewModel: AmazingImageViewModels.FetchImage.ViewModel.Failure) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            debugPrint(viewModel.error)
        }
    }
}
