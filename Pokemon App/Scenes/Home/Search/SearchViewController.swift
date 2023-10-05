//
//  SearchViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

// MARK: SearchViewController
class SearchViewController: BaseViewController {
    private var searchTimer: Timer?

    // MARK: UI Components
    private let searchController: UISearchController = {
        let resultsViewController = SearchResultsViewController.instance()
        let searchController = UISearchController(searchResultsController: resultsViewController)
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
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self

        navigationItem.searchController = searchController
    }
}

private extension SearchViewController {
    final func performSearch(_ query: String) {
        // TODO: Perform a search
    }
}

// MARK: UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines)  else {
            return
        }

        if text.count == 0 {
            print("updateSearchResults: no query text provided")
            // getResultsViewController().resetUI()
            return
        }
    }
}

// MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // TODO: Hide search view container
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // TODO: Show search view container
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { [weak self] _ in
            guard let self else { return }

            self.performSearch(searchText)
        }
    }
}
