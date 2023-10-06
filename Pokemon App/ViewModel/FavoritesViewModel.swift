//
//  FavoritesViewModel.swift
//  Pokemon App
//
//  Created by Emre Aydin on 6.10.2023.
//

import Foundation
import RxSwift

// MARK: FavoritesViewModelInput
protocol FavoritesViewModelInput: BaseViewModel {
    var favoritesDidChange: Observable<[Card]> { get }
    func subscribeToFavorites()
}

// MARK: FavoritesViewModel
class FavoritesViewModel: FavoritesViewModelInput {
    private let disposeBag = DisposeBag()

    var _favoritesDidChange: ReplaySubject<[Card]> = ReplaySubject.create(bufferSize: 1)
    var favoritesDidChange: RxSwift.Observable<[Card]> {
        get {
            return _favoritesDidChange
        }
    }
    var isLoading: RxSwift.ReplaySubject<Bool> = ReplaySubject.create(bufferSize: 1)
    
    var manager = FavoritesManager.shared
}

// MARK: Public
extension FavoritesViewModel {
    final func subscribeToFavorites() {
        // Manually trigger favorites update
        manager.triggerFavoritesUpdate()

        manager.favorites.subscribe { [weak self] favorites in
            guard let self else { return }
            self.dispatchFavorites(favorites)
        }.disposed(by: disposeBag)
    }
}

// MARK: Private
private extension FavoritesViewModel {
    final func dispatchFavorites(_ favoriteCards: [FavoriteCard]?) {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }

            let cards = self.convertFavoriteCardsToCards(favoriteCards)

            DispatchQueue.main.async {
                self._favoritesDidChange.onNext(cards)
            }
        }
    }
    
    final func convertFavoriteCardsToCards(_ favoriteCards: [FavoriteCard]?) -> [Card] {
        var cards: [Card] = []

        favoriteCards?.forEach({ favoriteCard in
            let card = Card(
                id: favoriteCard.id,
                name: favoriteCard.name,
                imageURL: favoriteCard.imageURL,
                hp: favoriteCard.hp
            )
            
            cards.append(card)
        })
        
        return cards
    }
}
