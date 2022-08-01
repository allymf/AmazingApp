//
//  EpisodeDetailsView.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation
import UIKit

protocol EpisodeDetailsViewModel {
    var posterPath: String { get }
    var name: String { get }
    var seasonAndEpisodeNumberText: String { get }
    var summary: String { get }
}

protocol EpisodeDetailsViewProtocol: ViewInitializer {
    var viewModel: EpisodeDetailsViewModel? { get set }
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
    
    var viewModel: EpisodeDetailsViewModel?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        addSubviews()
        constrainSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
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
    }
    
}
