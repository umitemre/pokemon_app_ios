//
//  HomeCoordinator.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

// MARK: HomeCoordinator
class HomeCoordinator: BaseCoordinator {
    override func start() {
        guard let controller = HomeViewController.instance() else { return }
        controller.coordinator = self
        
        let rootNavigationController = UINavigationController(rootViewController: controller)
        getSceneDelegate()?.window?.rootViewController = rootNavigationController
    }
}

// MARK: Private
private extension HomeCoordinator {
    func getSceneDelegate() -> SceneDelegate? {
        let application = UIApplication.shared

        guard let windowScene = application.connectedScenes.first as? UIWindowScene else { return nil }
        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return nil }

        return sceneDelegate
    }
}
