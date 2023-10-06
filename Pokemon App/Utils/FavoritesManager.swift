//
//  FavoritesManager.swift
//  Pokemon App
//
//  Created by Emre Aydin on 6.10.2023.
//

import UIKit
import CoreData
import RxSwift

// MARK: FavoritesManager
class FavoritesManager {
    private var context: NSManagedObjectContext!
    
    var favorites: ReplaySubject<[FavoriteCard]> = ReplaySubject<[FavoriteCard]>.create(bufferSize: 1)

    static let shared = FavoritesManager()

    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        self.context = appDelegate.persistentContainer.viewContext
    }

    func toggleFavorite(_ card: Card) {
        guard let id = card.id else { return }

        let favoriteExists = doesFavoriteExist(id)
        
        if favoriteExists {
            removeFromFavorites(id)
        } else {
            addToFavorites(card)
        }
    }

    func doesFavoriteExist(_ id: String?) -> Bool {
        guard let id else { return false }

        let fetchRequest: NSFetchRequest<FavoriteCard> = FavoriteCard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        let results = try? context.fetch(fetchRequest)

        return results?.first != nil
    }

    func triggerFavoritesUpdate() {
        updateFavorites()
    }
}

// MARK: Private
private extension FavoritesManager {
    final func addToFavorites (_ card: Card) {
        let favoriteItem = FavoriteCard(context: context)
        favoriteItem.id = card.id
        favoriteItem.name = card.name
        favoriteItem.imageURL = card.imageURL
        favoriteItem.hp = card.hp

        try? context.save()
        
        updateFavorites()
    }
    
    final func removeFromFavorites (_ id: String) {
        let fetchRequest: NSFetchRequest<FavoriteCard> = FavoriteCard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        guard let results = try? context.fetch(fetchRequest),
              let item = results.first else { return }

        context.delete(item)
        
        try? context.save()

        updateFavorites()
    }
    
    final func updateFavorites() {
        let fetchRequest: NSFetchRequest<FavoriteCard> = FavoriteCard.fetchRequest()
        let results = try? context.fetch(fetchRequest)

        guard let results else {
            favorites.onNext([])
            return
        }

        favorites.onNext(results)
    }
}

