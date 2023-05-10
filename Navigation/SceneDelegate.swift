//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Roman Vakulenko on 05.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: scene)

        let userProfileFeedVC = FeedViewController(post: Post.init(title: "Post's title"))
        userProfileFeedVC.title = "userProfileFeed"
        userProfileFeedVC.view.backgroundColor = .lightGray
        let userProfileFeedNavController = UINavigationController(rootViewController: userProfileFeedVC)

        let userProfilePageVC = ProfileViewController()
        userProfilePageVC.title = "userProfilePage"
        userProfilePageVC.view.backgroundColor = .cyan
        let userProfilePageNavController = UINavigationController(rootViewController: userProfilePageVC)

        let tabBarController = UITabBarController()

        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        let newspaperIcon = UIImage(systemName: "newspaper", withConfiguration: iconConfig)
        userProfileFeedNavController.tabBarItem = UITabBarItem(title: "userProfileFeed", image: newspaperIcon, tag: 0)
        userProfilePageNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)

        tabBarController.viewControllers = [userProfileFeedNavController, userProfilePageNavController]
        // или через функциональное программирование добавить в табБарКонтроллер пару НавигацКонтроллеров
        // let controllers = [userProfileFeedNavController, userProfilePageNavController]
        // tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0 }

        tabBarController.selectedIndex = 1
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        self.window = window
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

