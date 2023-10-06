//
//  FavoritesViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit
import RxSwift

// MARK: FavoritesViewController
class FavoritesViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    
    // MARK: Outlets
    @IBOutlet private weak var cardsView: CardsView!

    // MARK: MVVM-C Components
    var viewModel: FavoritesViewModelInput? {
        get { baseVM as? FavoritesViewModelInput }
        set { baseVM = newValue }
    }
    
    var coordinator: HomeCoordinator?

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
        setObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.subscribeToFavorites()
    }
    
    private func setObservers() {
        viewModel?.favoritesDidChange.subscribe { [weak self] favorites in
            guard let self else { return }
            
            let cardsResult = CardsResult(cards: favorites.element)
            self.cardsView.setCardsResult(cardsResult)
        }.disposed(by: disposeBag)
    }
}

// MARK: Configuration
private extension FavoritesViewController {
    final func configureUI() {
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureCardsView()
    }
    
    final func configureCardsView() {
        cardsView.delegate = self
    }
}

// MARK: CardsViewDelegate
extension FavoritesViewController: CardsViewDelegate {
    func didTapItem(_ card: Card?) {
        guard let card else { return }

        coordinator?.routeToCardDetail(card)
    }
    
    func didLongPressItem(_ card: Card?) {
        
    }
}
