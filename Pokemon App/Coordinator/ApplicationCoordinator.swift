//
//  ApplicationCoordinator.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

// MARK: ApplicationCoordinator
class ApplicationCoordinator: BaseCoordinator {
    override func start() {
        guard let controller = SplashViewController.instance() else { return }
        navigationController?.pushViewController(controller, animated: false)
    }
}
