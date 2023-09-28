//
//  SceneDelegate.swift
//  GatewayAssignment
//
//  Created by Aaditya Singh on 27/09/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let viewModel = MainViewModel(networkingManager: NetworkManager())
        window?.rootViewController = UINavigationController(rootViewController: ViewController(viewModel: viewModel))
        window?.makeKeyAndVisible()
    }

}

