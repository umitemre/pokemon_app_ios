//
//  FavoritesManagerTest.swift
//  Pokemon AppTests
//
//  Created by Emre Aydin on 6.10.2023.
//

import Foundation
import XCTest
import RxSwift
@testable import Pokemon_App

// MARK: FavoritesManagerTest
class FavoritesManagerTest: XCTestCase {
    private let disposeBag = DisposeBag()
    let manager: FavoritesManager = FavoritesManager.shared
    
    func test_WhenACardIsAddedToFavorites_ManagerShouldNotify() {
        let expectation = XCTestExpectation(description: "FavoritesResult")

        manager.favorites.subscribe { favoriteCards in
            expectation.fulfill()
        }.disposed(by: disposeBag)
        
        manager.toggleFavorite(.init(id: "123"))

        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func test_DoesFavoriteExist_ShouldReturnTrue() {
        manager.toggleFavorite(.init(id: "456"))
        let isFavorited = manager.doesFavoriteExist("456")
        
        XCTAssertTrue(isFavorited)
    }
    
}
