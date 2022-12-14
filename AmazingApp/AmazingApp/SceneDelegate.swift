//
//  SceneDelegate.swift
//  AmazingApp
//
//  Created by Alysson on 30/07/22.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController(rootViewController: ShowListSceneFactory.makeScene())
        navigationController.setupStyle()
        self.window?.rootViewController = navigationController
    }
    
}
