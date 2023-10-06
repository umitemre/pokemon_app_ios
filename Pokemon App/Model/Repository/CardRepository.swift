//
//  CardRepository.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation

public class CardRepository {
    /// Fetches cards that have HP greater than or equal to provided health
    /// - Parameter completion: Returns card result or error
    func fetchCards(hp: Int, completion: @escaping (Result<CardsResult, Error>) -> Void) {
        NetworkLayer.shared
            .url("https://api.pokemontcg.io/v1/cards?hp=gte\(hp)")
            .makeRequest { (result: Result<CardsResult, Error>) in
                completion(result)
            }
    }
    
    /// Fetches the card with given ID
    /// - Parameter completion: Returns card or error
    func fetchCard(id: String, completion: @escaping (Result<CardResult, Error>) -> Void) {
        NetworkLayer.shared
            .url("https://api.pokemontcg.io/v1/cards/\(id)")
            .makeRequest { (result: Result<CardResult, Error>) in
                completion(result)
            }
    }
}
