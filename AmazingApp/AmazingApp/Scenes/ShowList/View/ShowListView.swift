//
//  ShowListView.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import UIKit

protocol ShowListViewActions {
    var prefetchNextShowsPage: ([IndexPath]) -> Void { get }
    var didSelectItemAt: (Int) -> Void { get }
}

protocol ShowListViewProtocol: ViewInitializer {
    var actions: ShowListViewActions? { get set }
    func updateShowViewModels(_ showViewModels: [ShowCellModel])
    func insertShowViewModels(_ newShowViewModels: [ShowCellModel])
    func renderLoadingState()
}

final class ShowListView: UIView, ShowListViewProtocol {
    
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
        collectionView.prefetchDataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    private var showViewModels = [ShowCellModel]()

    var actions: ShowListViewActions?
    
    // MARK: - Initialization
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        addSubviews()
        constrainSubviews()
        additionalConfigurations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CodedView methods
    func addSubviews() {
        addSubview(collectionView)
        addSubview(activityIndicator)
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
        backgroundColor = .systemGray6
    }
    
    // MARK: - Public API
    func updateShowViewModels(_ showViewModels: [ShowCellModel]) {
        self.showViewModels = showViewModels
        collectionView.isHidden = false
        activityIndicator.stopAnimating()
        collectionView.reloadData()
    }
    
    func renderLoadingState() {
        collectionView.isHidden = true
        activityIndicator.startAnimating()
    }

    func insertShowViewModels(_ newShowViewModels: [ShowCellModel]) {
        self.showViewModels.append(contentsOf: newShowViewModels)
        
        let newIndexPaths = makeInsertionIndexpaths(numberOfItems: showViewModels.count, numberOfNewItems: newShowViewModels.count)
        collectionView.insertItems(at: newIndexPaths)
    }
    
    private func makeInsertionIndexpaths(numberOfItems: Int, numberOfNewItems: Int) -> [IndexPath] {
        let startIndex = numberOfItems - numberOfNewItems
        let endIndex = numberOfItems - 1
        
        var newIndexPaths = [IndexPath]()
        for item in startIndex...endIndex {
            newIndexPaths.append(IndexPath(item: item, section: 0))
        }
        
        return newIndexPaths
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
            static let itemHeight: CGFloat = 280
        }
    }
}

extension ShowListView: UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        actions?.prefetchNextShowsPage(indexPaths)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return showViewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            ShowCollectionViewCell.self,
            for: indexPath
        )
        
        guard let viewModel = showViewModels[safeIndex: indexPath.item] else { return cell }
        
        cell.updateData(with: viewModel)
        
        return cell
    }
    
    
}

extension ShowListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        actions?.didSelectItemAt(indexPath.item)
    }
    
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
