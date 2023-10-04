//
//  BaseCoordinator.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

protocol BaseCoordinatorProtocol: AnyObject {
    var childCoordinators: [BaseCoordinator] { get set }
    var navigationController: UINavigationController? { get set }

    func start()
}

class BaseCoordinator: BaseCoordinatorProtocol {
    var childCoordinators: [BaseCoordinator] = []
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    func start() {
        
    }
}
