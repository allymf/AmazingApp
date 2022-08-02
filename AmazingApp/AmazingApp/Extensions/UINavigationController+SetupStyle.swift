//
//  UINavigationController+SetupStyle.swift
//  AmazingApp
//
//  Created by Alysson on 01/08/22.
//

import Foundation
import UIKit

extension UINavigationController {
    func setupStyle() {
        let accentColor = UIColor(named: "AccentColor") ?? UIColor()
        let mainColor = UIColor(named: "MainColor") ?? UIColor()
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = mainColor
            appearance.titleTextAttributes = [.foregroundColor: accentColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: accentColor]

            UINavigationBar.appearance().tintColor = accentColor
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = accentColor
            UINavigationBar.appearance().barTintColor = mainColor
            UINavigationBar.appearance().isTranslucent = false
        }
        
    }
    
}
