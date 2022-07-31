//
//  ShowListViewController.swift
//  AmazingApp
//
//  Created by Alysson on 30/07/22.
//
import UIKit

final class ShowListViewController: UIViewController {
    

    let repository = ShowRepository()
    
    var shows = [Show]() {
        didSet {
            listAllShows()
        }
    }
    
    override func loadView() {
        view = ShowsListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.fetchShows(page: 1) { [weak self] result in
            switch result {
            case let .success(response):
                self?.shows = response
            case let .failure(error):
                debugPrint(error)
            }
        }
    }

    func listAllShows() {
        
        shows.forEach {
            debugPrint("Show", $0.name)
        }
        
        
    }
    
}

