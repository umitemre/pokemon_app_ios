//
//  SearchViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit
import RxSwift

// MARK: SearchViewController
class SearchViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    private var searchTimer: Timer?
    
    // MARK: Outlets
    @IBOutlet private weak var recentlyViewed: RecentlyViewedView!
    
    // MARK: MVVM-C Components
    var viewModel: SearchViewModelInput? {
        get { baseVM as? SearchViewModelInput }
        set { baseVM = newValue }
    }
    
    var coordinator: HomeCoordinator? {
        didSet {
            getResultsViewController().coordinator = coordinator
        }
    }

    // MARK: UI Components
    private lazy var searchController: UISearchController = {
        let resultsViewController = SearchResultsViewController.instance()
        resultsViewController?.viewModel = viewModel
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
        setObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.subscribeToFavorites()
        viewModel?.subscribeToRecentlyViewed()
    }

    private func setObservers() {
        viewModel?.favoritesDidChange.subscribe { [weak self] _ in
            guard let self else { return }
            
            self.recentlyViewed.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel?.recentlyViewedDidChanged.subscribe { [weak self] data in
            guard let self,
                  let results = data.element else { return }
        
            self.recentlyViewed.updateData(results)
        }.disposed(by: disposeBag)

        viewModel?.searchResultDidChange.subscribe { [weak self] data in
            guard let self else { return }

            let results = data.element
            self.getResultsViewController().setSearchResults(results)
        }.disposed(by: disposeBag)
    }
}

// MARK: Configuration
private extension SearchViewController {
    final func configureUI() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true

        configureSearchBar()
        configureSearchResultsViewController()
        configureRecentlyViewedView()
    }

    final func configureSearchBar() {
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self

        navigationItem.searchController = searchController
    }
    
    final func configureSearchResultsViewController() {
        getResultsViewController().delegate = self
    }
    
    final func configureRecentlyViewedView() {
        recentlyViewed.delegate = self
    }
}

// MARK: Private
private extension SearchViewController {
    final func performSearch(_ query: String) {
        guard let hp = Int(query) else { return }
        viewModel?.fetchSearchResults(hp: hp)
    }
    
    final func getResultsViewController() -> SearchResultsViewController {
        return searchController.searchResultsController as! SearchResultsViewController
    }
}

// MARK: UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines)  else {
            return
        }

        if text.count == 0 {
            getResultsViewController().resetUI()
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
        getResultsViewController().resetUI()

        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { [weak self] _ in
            guard let self else { return }

            self.performSearch(searchText)
        }
    }
}

// MARK: CardsViewDelegate
extension SearchViewController: CardsViewDelegate {
    func didTapItem(_ card: Card?) {
        guard let card else { return }

        coordinator?.routeToCardDetail(card)
    }

    func didLongPressItem(_ card: Card?) {
        guard let card else { return }

        FavoritesManager.shared.toggleFavorite(card)
    }
}
