//
//  ShowDetailsView.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import UIKit

protocol ShowDetailsViewProtocol: ViewInitializer {
    var showDetailsHeaderViewModel: ShowDetails.ShowDetailHeaderViewModel? { get set }
    var seasonViewModels: [ShowDetails.SeasonViewModel] { get set }
}

final class ShowDetailsView: UIView, ShowDetailsViewProtocol {
    
    // MARK: - Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        tableView.contentInset = .zero
        
        tableView.dataSource = self
        
        return tableView
    }()
    
    var showDetailsHeaderViewModel: ShowDetails.ShowDetailHeaderViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var seasonViewModels: [ShowDetails.SeasonViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
}


extension ShowDetailsView: UITableViewDataSource {
    
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
        <#code#>
    }
}
