//
//  CardRepositoryMock.swift
//  Pokemon AppTests
//
//  Created by Emre Aydin on 6.10.2023.
//

import Foundation
@testable import Pokemon_App

// MARK: ErrorMock
enum ErrorMock: Error {
    case error
}

// MARK: CardRepositoryMock
class CardRepositoryMock: CardRepository {
    private var mockCards: [Card]?
    private var mockCard: Card?
    private let isSuccess: Bool

    init(_ cards: [Card], isSuccess: Bool = true) {
        self.mockCards = cards
        self.isSuccess = isSuccess
    }
    
    init(_ card: Card, isSuccess: Bool = true) {
        self.mockCard = card
        self.isSuccess = isSuccess
    }

    override func fetchCard(id: String, completion: @escaping (Result<CardResult, Error>) -> Void) {
        guard let mockCard, isSuccess else {
            completion(.failure(ErrorMock.error))
            return
        }

        completion(.success(.init(card: mockCard)))
    }
    
    override func fetchCards(hp: Int, completion: @escaping (Result<CardsResult, Error>) -> Void) {
        guard let mockCards, isSuccess else {
            completion(.failure(ErrorMock.error))
            return
        }

        completion(.success(.init(cards: mockCards)))
    }
}
