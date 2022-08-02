//
//  UITableView+Reuser.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation
import UIKit

extension UITableView {
    func register(_ cellType: UITableViewCell.Type) {
        register(
            cellType,
            forCellReuseIdentifier: cellType.reuseIdentifier
        )
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellType.reuseIdentifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Unable to find cell registered with the following reuseIdentifier: \(cellType.reuseIdentifier)")
        }
        
        return cell
    }
}
