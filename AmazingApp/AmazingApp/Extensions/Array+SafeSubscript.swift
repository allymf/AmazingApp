//
//  Array+SafeSubscript.swift
//  AmazingApp
//
//  Created by Alysson on 31/07/22.
//

import Foundation

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else { return nil }
        return self[index]
    }
}
