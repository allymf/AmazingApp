//
//  ShowListView.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import UIKit

final class ShowListView: UIView {
    
    // MARK: - Components
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.style = .medium
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    private lazy var refreshControl = UIRefreshControl()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
    
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        collectionView.contentInset = Metrics.CollectionView.contentInset
        
        collectionView.refreshControl = refreshControl
        collectionView.register(ShowCollectionViewCell.self)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()

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
        addSubview(activityIndicator)
        addSubview(collectionView)
    }
    
    func constrainSubviews() {
        NSLayoutConstraint.activate(
            [
                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
    
    func additionalConfigurations() {
        backgroundColor = .systemGray4
    }

}

extension ShowListView {
    enum Metrics {
        enum CollectionView {
            static let contentInset = UIEdgeInsets(
                top: 16,
                left: 16,
                bottom: 16,
                right: 16
            )
            
            static let interItemSpacing: CGFloat = 16
            static let totalHorizontalMargin: CGFloat = 24
            static let numberOfItemsPerRow: CGFloat = 2
            static let itemHeight: CGFloat = 200
        }
    }
}

extension ShowListView: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 20
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            ShowCollectionViewCell.self,
            for: indexPath
        )
        
        return cell
    }
    
    
}

extension ShowListView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.bounds.width / Metrics.CollectionView.numberOfItemsPerRow) - Metrics.CollectionView.totalHorizontalMargin
        return CGSize(
            width: width,
            height: Metrics.CollectionView.itemHeight
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Metrics.CollectionView.interItemSpacing
    }
}
