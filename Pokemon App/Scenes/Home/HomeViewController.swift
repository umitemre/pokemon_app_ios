//
//  HomeViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

// MARK: HomeViewController
class HomeViewController: BaseViewController {
    var searchViewController: SearchViewController?
    var favoritesViewController: FavoritesViewController?

    private let mainTabController = UITabBarController()

    // MARK: MVVM-C Component
    var coordinator: HomeCoordinator? {
        get { baseCoordinator as? HomeCoordinator }
        set { baseCoordinator = newValue }
    }

    static func instance() -> HomeViewController? {
        let controller = HomeViewController()
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: Configuration
private extension HomeViewController{
    final func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = true

        configureTabBar()
    }
    
    final func configureTabBar() {
        guard let searchViewController,
              let favoritesViewController else { return }

        mainTabController.viewControllers = [
            createNavigationController(for: searchViewController),
            createNavigationController(for: favoritesViewController),
        ]
        mainTabController.selectedIndex = 0

        addChild(mainTabController)
        view.addSubview(mainTabController.view)
        mainTabController.didMove(toParent: self)
    }
}

// MARK: Private
private extension HomeViewController {
    final func createNavigationController(for rootViewController: UIViewController) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        return navController
    }
}
