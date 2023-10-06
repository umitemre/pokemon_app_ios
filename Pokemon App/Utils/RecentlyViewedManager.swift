//
//  RecentlyViewedManager.swift
//  Pokemon App
//
//  Created by Emre Aydin on 7.10.2023.
//

import UIKit
import CoreData
import RxSwift


// MARK: RecentlyViewedManager
class RecentlyViewedManager {
    private var context: NSManagedObjectContext!
    
    var recentlyViewed: ReplaySubject<[RecentlyViewedCard]> = ReplaySubject<[RecentlyViewedCard]>.create(bufferSize: 1)

    static let shared = RecentlyViewedManager()

    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        self.context = appDelegate.persistentContainer.viewContext
    }

    func triggerRecentlyViewedUpdate() {
        updateRecentlyViewed()
    }
}

// MARK: Public
extension RecentlyViewedManager {
    func addToRecentlyViewed (_ card: Card) {
        checkRemoveExistingCard(card.id)

        let recentlyViewedItem = RecentlyViewedCard(context: context)
        recentlyViewedItem.id = card.id
        recentlyViewedItem.name = card.name
        recentlyViewedItem.imageURL = card.imageURL
        recentlyViewedItem.hp = card.hp

        try? context.save()
        
        removeOverflowCard()
        updateRecentlyViewed()
    }

}

// MARK: Private
private extension RecentlyViewedManager {
    private func checkRemoveExistingCard(_ cardId: String?) {
        guard let cardId else { return }

        let fetchRequest: NSFetchRequest<RecentlyViewedCard> = RecentlyViewedCard.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", cardId)

        let results = try? context.fetch(fetchRequest)
        
        if let existingCard = results?.first {
            context.delete(existingCard)
        }
    }

    final func removeOverflowCard() {
        guard let items = try? context.fetch(RecentlyViewedCard.fetchRequest()) else {
            return
        }

        if items.count <= 10 {
            return
        }

        // Remove last
        guard let last = items.last else {
            return
        }
        
        context.delete(last)
    }

    final func updateRecentlyViewed() {
        let fetchRequest: NSFetchRequest<RecentlyViewedCard> = RecentlyViewedCard.fetchRequest()
        let results = try? context.fetch(fetchRequest)

        guard let results else {
            recentlyViewed.onNext([])
            return
        }

        recentlyViewed.onNext(results)
    }
}
