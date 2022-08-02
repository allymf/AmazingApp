//
//  ShowDetailsView.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

protocol ShowDetailsViewActions {
    var didSelectRowAt: (IndexPath) -> Void { get }
}

protocol ShowDetailsViewProtocol: ViewInitializer {
    var actions: ShowDetailsViewActions? { get set }
    var showDetailsHeaderViewModel: ShowDetails.ShowDetailHeaderViewModel? { get set }
    var seasonViewModels: [ShowDetails.SeasonViewModel] { get set }
}

final class ShowDetailsView: UIView, ShowDetailsViewProtocol {
    
    // MARK: - Components
    private lazy var tableHeaderView: EntityDetailsView = {
        let view = EntityDetailsView()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        tableView.contentInset = .zero
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.register(EntityTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableHeaderView = tableHeaderView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Properties
    var actions: ShowDetailsViewActions?
    
    var showDetailsHeaderViewModel: ShowDetails.ShowDetailHeaderViewModel? {
        didSet {
            tableHeaderView.viewModel = showDetailsHeaderViewModel
        }
    }
    
    var seasonViewModels: [ShowDetails.SeasonViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if tableHeaderView.frame.size.height != size.height {
            tableHeaderView.frame.size.height = size.height + 200
            tableHeaderView.setNeedsLayout()
            tableHeaderView.layoutIfNeeded()
            tableView.tableHeaderView = tableHeaderView
            tableView.layoutIfNeeded()
        }
    }
    
    func addSubviews() {
        addSubview(tableView)
    }
    
    func constrainSubviews() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
    
    func additionalConfigurations() {
        backgroundColor = .white
    }
    
    private func getEpisodeViewModel(for indexPath: IndexPath) -> ShowDetails.EpisodeViewModel? {
        return seasonViewModels[safeIndex: indexPath.section]?.episodes[safeIndex: indexPath.row]
    }
    
}


extension ShowDetailsView: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return seasonViewModels[safeIndex: section]?.seasonTitle
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        seasonViewModels.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        guard let numberOfEpisodes = seasonViewModels[safeIndex: section]?.episodes.count else { return 0 }
        return numberOfEpisodes
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            EntityTableViewCell.self,
            for: indexPath
        )
        
        guard let episodeViewModel = getEpisodeViewModel(for: indexPath) else { return cell }
        
        cell.viewModel = episodeViewModel
        
        return cell
    }
}

extension ShowDetailsView: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        actions?.didSelectRowAt(indexPath)
    }
}
