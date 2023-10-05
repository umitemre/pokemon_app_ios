//
//  CardRepository.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation

public class CardRepository {
    /// Fetches cards that have HP greater than or equal to provided health
    /// - Parameter completion: Returns card result or error based
    func fetchCards(hp: Int, completion: @escaping (Result<CardsResult, Error>) -> Void) {
        NetworkLayer.shared
            .url("https://api.pokemontcg.io/v1/cards?hp=gte\(hp)")
            .makeRequest { (result: Result<CardsResult, Error>) in
                completion(result)
            }
    }
}
