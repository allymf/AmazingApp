//
//  Reusable.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String { String(describing: self.self) }
}

extension UICollectionViewCell: Reusable {}
