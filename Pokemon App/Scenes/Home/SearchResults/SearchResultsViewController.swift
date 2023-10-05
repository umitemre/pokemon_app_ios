//
//  SearchResultsViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation
import UIKit

// MARK: SearchResultsViewController
class SearchResultsViewController: BaseViewController {
    // MARK: Outlets
    @IBOutlet private weak var resultsCountLabel: UILabel!
    @IBOutlet private weak var cardsView: CardsView!

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
