//
//  SceneDelegate.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let store: DataStore = FileDataStore(store: FileStoreReader(with: .main))

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let s = (scene as? UIWindowScene) else { return }
        // Programmatically create and attach a `ViewController` to the first window in the scene
        window = UIWindow(windowScene: s)
        window?.rootViewController = MainViewController(store: store, viewModel: .init(store: store))
        // Assigned view controller, make window the key window and ensure it is visible.
        window?.makeKeyAndVisible()
    }

}

