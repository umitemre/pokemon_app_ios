//
//  SearchResultsViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation
import UIKit
import RxSwift

// MARK: SearchResultsViewController
class SearchResultsViewController: BaseViewController {
    private let disposeBag = DisposeBag()

    // MARK: Outlets
    @IBOutlet private weak var resultsCountLabel: UILabel!
    @IBOutlet private weak var cardsView: CardsView!

    // MARK: MVVM-C Components
    var viewModel: BaseViewModelProtocol?  {
        get { baseVM }
        set { baseVM = newValue }
    }
    var coordinator: HomeCoordinator?

    // MARK: Data
    private var cardsResult: CardsResult? {
        didSet {
            cardsView.setCardsResult(cardsResult)
            
            let count = cardsResult?.cards?.count ?? 0
            if count == 0 {
                resultsCountLabel.text = "No results found"
            } else if count == 1 {
                resultsCountLabel.text = "1 result found"
            } else {
                resultsCountLabel.text = "\(count) results found"
            }
            
            resultsCountLabel.isHidden = false
        }
    }

    static func instance() -> SearchResultsViewController? {
        return instance(fromName: "SearchResults")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        viewModel?.subscribeToFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.favoritesDidChange.subscribe { [weak self] _ in
            guard let self else { return }
            self.cardsView.reloadData()
        }.disposed(by: disposeBag)
    }
}

// MARK: Configuration
private extension SearchResultsViewController {
    final func configureUI() {
        configureCardsView()
    }
    
    final func configureCardsView() {
        cardsView.delegate = self
    }
}

// MARK: Public
extension SearchResultsViewController {
    final func setSearchResults(_ cardsResult: CardsResult?) {
        self.cardsResult = cardsResult
    }
    
    final func resetUI() {
        self.cardsResult = nil
        self.resultsCountLabel.isHidden = true
    }
}

// MARK: CardsViewDelegate
extension SearchResultsViewController: CardsViewDelegate {
    func didTapItem(_ card: Card?) {
        guard let card else { return }

        coordinator?.routeToCardDetail(card)
    }

    func didLongPressItem(_ card: Card?) {
        guard let card else { return }

        FavoritesManager.shared.toggleFavorite(card)
    }
}
