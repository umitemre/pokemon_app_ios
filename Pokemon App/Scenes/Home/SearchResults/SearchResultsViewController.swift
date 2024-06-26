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
    
    weak var delegate: CardsViewDelegate?

    // MARK: MVVM-C Components
    var viewModel: SearchViewModelInput?  {
        get { baseVM as? SearchViewModelInput }
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
        setObservers()
        viewModel?.subscribeToFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.favoritesDidChange.subscribe { [weak self] _ in
            guard let self else { return }
            self.cardsView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    final func setObservers() {
        viewModel?.searchResultError.subscribe { [weak self] _ in
            guard let self else { return }
            
            self.showRequestFailedAlert(canTryAgain: true, shouldShowOKButton: true) {
                self.viewModel?.retryLastSearch()
            }
        }.disposed(by: disposeBag)
    }
}

// MARK: Configuration
private extension SearchResultsViewController {
    final func configureUI() {
        configureCardsView()
    }
    
    final func configureCardsView() {
        cardsView.delegate = delegate
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
