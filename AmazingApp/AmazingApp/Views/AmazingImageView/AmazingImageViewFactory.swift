//
//  AmazingImageViewFactory.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

struct AmazingImageViewFactory {
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
