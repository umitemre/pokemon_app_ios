//
//  RecentlyViewedView.swift
//  Pokemon App
//
//  Created by Emre Aydin on 7.10.2023.
//

import Foundation
import UIKit

// MARK: RecentlyViewed
class RecentlyViewedView: UIView {
    // MARK: Outlets
    @IBOutlet private weak var cardsView: CardsView!
    @IBOutlet private weak var emptyView: UIView!

    // MARK: Delegate
    weak var delegate: CardsViewDelegate? {
        didSet {
            cardsView.delegate = delegate
        }
    }

    // MARK: Data
    private var cards: [Card]? {
        didSet {
            guard let cards else { return }
            
            if cards.count == 0 {
                cardsView.setCardsResult(nil)
                cardsView.isHidden = true
                emptyView.isHidden = false
                return
            }
 
            cardsView.resetScroll()
            cardsView.setCardsResult(.init(cards: cards))
            cardsView.isHidden = false
            emptyView.isHidden = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        configureUI()
    }
}

// MARK: Init
private extension RecentlyViewedView {
    final func commonInit() {
        let view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}

// MARK: Configuration
private extension RecentlyViewedView {
    final func configureUI() {
        configureCardsView()
        configureEmptyView()
    }
    
    final func configureCardsView() {
        cardsView.configure(withOrientation: .horizontal)
        cardsView.isHidden = true
    }

    final func configureEmptyView() {
        emptyView.isHidden = false
    }
}

// MARK: Public
extension RecentlyViewedView {
    final func updateData(_ cards: [Card]) {
        self.cards = cards
    }
    
    final func reloadData() {
        cardsView.reloadData()
    }
}
