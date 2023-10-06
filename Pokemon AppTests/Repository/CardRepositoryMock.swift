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
    private var mockCardsResult: CardsResult?
    private var mockCardResult: CardResult?
    private let isSuccess: Bool

    init(_ cardsResult: CardsResult, isSuccess: Bool = true) {
        self.mockCardsResult = cardsResult
        self.isSuccess = isSuccess
    }
    
    init(_ cardResult: CardResult, isSuccess: Bool = true) {
        self.mockCardResult = cardResult
        self.isSuccess = isSuccess
    }

    override func fetchCard(id: String, completion: @escaping (Result<CardResult, Error>) -> Void) {
        guard let mockCardResult, isSuccess else {
            completion(.failure(ErrorMock.error))
            return
        }

        completion(.success(mockCardResult))
    }
    
    override func fetchCards(hp: Int, completion: @escaping (Result<CardsResult, Error>) -> Void) {
        guard let mockCardsResult, isSuccess else {
            completion(.failure(ErrorMock.error))
            return
        }

        completion(.success(mockCardsResult))
    }
}
