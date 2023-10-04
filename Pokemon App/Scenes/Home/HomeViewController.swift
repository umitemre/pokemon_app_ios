//
//  HomeViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

// MARK: HomeViewController
class HomeViewController: BaseViewController {
    private let searchViewController = SearchViewController.instance()
    private let favoritesViewController = FavoritesViewController.instance()

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
        
        title = "Pokemon App"
        navigationController?.navigationBar.prefersLargeTitles = true

        configureTabBar()
    }
    
    final func configureTabBar() {
        mainTabController.viewControllers = [
            self.searchViewController!,
            self.favoritesViewController!
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
