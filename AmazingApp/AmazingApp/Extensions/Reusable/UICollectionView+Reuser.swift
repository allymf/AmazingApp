//
//  UICollectionView+Reuser.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import UIKit

extension UICollectionView {
    func register(_ cellType: UICollectionViewCell.Type) {
        register(
            cellType,
            forCellWithReuseIdentifier: cellType.reuseIdentifier
        )
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cellType.reuseIdentifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Unable to find cell registered with the following reuseIdentifier: \(cellType.reuseIdentifier)")
        }
        
        return cell
    }
}
