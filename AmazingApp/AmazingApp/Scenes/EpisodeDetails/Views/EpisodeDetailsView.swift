//
//  EpisodeDetailsView.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation
import UIKit

protocol EpisodeDetailsViewProtocol: ViewInitializer {
    var viewModel: EntityDetailsViewModel? { get set }
}

final class EpisodeDetailsView: UIView, EpisodeDetailsViewProtocol {
    
    // MARK: - Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.contentInset = .zero
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()

    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let detailsView: EntityDetailsView = {
        let view = EntityDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hideImage()
        return view
    }()
    
    var viewModel: EntityDetailsViewModel? {
        didSet {
            detailsView.viewModel = viewModel
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        addSubviews()
        constrainSubviews()
        additionalConfigurations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(detailsView)
    }
    
    func constrainSubviews() {
        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                detailsView.topAnchor.constraint(equalTo: contentView.topAnchor),
                detailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                detailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                detailsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
    }
    
}
