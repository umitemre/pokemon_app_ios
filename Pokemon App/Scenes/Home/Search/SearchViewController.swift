//
//  SearchViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

class SearchViewController: BaseViewController {
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Type health here to search Pokémon"
        return searchController
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    }

    static func instance() -> SearchViewController? {
        return instance(fromName: "Search")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: Configuration
private extension SearchViewController {
    final func configureUI() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true

        configureSearchBar()
    }

    final func configureSearchBar() {
        navigationItem.searchController = searchController
    }
}
