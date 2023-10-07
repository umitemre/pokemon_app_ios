//
//  RecentlyViewedCard+Extensions.swift
//  Pokemon App
//
//  Created by Emre Aydin on 7.10.2023.
//

import Foundation
import CoreData

extension Array where Element == RecentlyViewedCard {
    var toCards: [Card] {
        var cards: [Card] = []
        self.forEach { recentlyViewedCard in
            let card = Card(
                id: recentlyViewedCard.id,
                name: recentlyViewedCard.name,
                imageURL: recentlyViewedCard.imageURL,
                hp: recentlyViewedCard.hp
            )

            cards.append(card)
        }

        return cards
    }
}
