//
//  BaseViewModel.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import Foundation
import RxSwift

// MARK: BaseViewModelProtocol
protocol BaseViewModelProtocol: AnyObject {
    var favoritesManager: FavoritesManager { get }
    var favoritesDidChange: RxSwift.Observable<[Card]> { get }
    var isLoading: ReplaySubject<Bool> { get set }
    
    func subscribeToFavorites()
}

// MARK: BaseViewModel
class BaseViewModel: BaseViewModelProtocol {
    private let disposeBag = DisposeBag()

    var _favoritesDidChange: RxSwift.ReplaySubject<[Card]> = ReplaySubject.create(bufferSize: 1)
    var favoritesDidChange: RxSwift.Observable<[Card]> {
        get {
            _favoritesDidChange
        }
    }

    var isLoading: RxSwift.ReplaySubject<Bool> = ReplaySubject.create(bufferSize: 1)
    let favoritesManager: FavoritesManager = FavoritesManager.shared
}

// MARK: Public
extension BaseViewModel {
    final func subscribeToFavorites() {
        // Manually trigger favorites update
        favoritesManager.triggerFavoritesUpdate()

        favoritesManager.favorites.subscribe { [weak self] favorites in
            guard let self else { return }
            self.dispatchFavorites(favorites)
        }.disposed(by: disposeBag)
    }
}

// MARK: Private
private extension BaseViewModel {
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
