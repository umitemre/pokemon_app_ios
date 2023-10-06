//
//  CardDetailViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation
import UIKit
import RxSwift

// MARK: CardDetailViewController
class CardDetailViewController: BaseViewController {
    private let disposeBag = DisposeBag()

    // MARK: Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var hpLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    
    // MARK: UI Components
    private var rightButton: UIBarButtonItem!

    // MARK: MVVM-C Components
    var viewModel: CardDetailViewModelInput? {
        get { baseVM as? CardDetailViewModelInput }
        set { baseVM = newValue}
    }

    // MARK: Data
    private var cardID: String?
    private var card: Card? {
        didSet {
            guard let card else { return }

            RecentlyViewedManager.shared.addToRecentlyViewed(card)

            self.imageView.loadImageFromUrl(card.imageURLHiRes)
            
            self.titleLabel.text = card.name ?? ""
            self.hpLabel.text = "HP: \(card.hp ?? "")"
            self.artistNameLabel.text = "Artist: \(card.artist ?? "")"
        }
    }
    private var isFavorited = false

    static func instance(withCard card: Card) -> CardDetailViewController? {
        let controller = instance(fromName: "CardDetailView")
        controller?.cardID = card.id

        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        
        guard let cardID else { return }
        
        viewModel?.fetchFavoriteStatus(cardID)
        viewModel?.fetchCard(cardID)
    }
    
    private func setObservers() {
        viewModel?.isFavorited.subscribe { [weak self] isFavorited in
            guard let self else { return }

            self.isFavorited = isFavorited
            self.updateFavoriteButton()
        }.disposed(by: disposeBag)

        viewModel?.cardResultDidChange.subscribe { [weak self] result in
            guard let self,
                  let card = result.element?.card else { return }

            self.card = card
        }.disposed(by: disposeBag)
        
        viewModel?.cardResultError.subscribe { [weak self] _ in
            guard let self else { return }
            
            self.showRequestFailedAlert(canTryAgain: false) { [weak self] in
                guard let self else { return }

                self.navigationController?.popViewController(animated: true)
            }
        }.disposed(by: disposeBag)
    }
}

// MARK: Configuration
private extension CardDetailViewController{
    final func configureUI() {
        title = "Details"
        
        configureFavoriteButton()
        configureLabels()
    }
    
    final func configureFavoriteButton() {
        rightButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(rightButtonTapped))

        navigationItem.rightBarButtonItem = rightButton
    }
    
    final func configureLabels() {
        self.titleLabel.text = ""
        self.hpLabel.text = ""
        self.artistNameLabel.text = ""
    }
}

// MARK: Actions
private extension CardDetailViewController {
    final func updateFavoriteButton() {
        if isFavorited {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
        }
    }

    @objc func rightButtonTapped() {
        guard let card else { return }
        FavoritesManager.shared.toggleFavorite(card)
        isFavorited = !isFavorited

        updateFavoriteButton()
    }
}
