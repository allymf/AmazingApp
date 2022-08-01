//
//  String+RemoveHTMLMarkups.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation

extension String {
    func removeHTMLMarks() -> String {
        return self.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression,
            range: nil
        )
    }
}
