//
//  FavoritesViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

// MARK: FavoritesViewController
class FavoritesViewController: BaseViewController {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    }

    static func instance() -> FavoritesViewController? {
        return instance(fromName: "Favorites")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: Configuration
private extension FavoritesViewController {
    final func configureUI() {
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
