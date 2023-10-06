//
//  SearchViewControllerTest.swift
//  Pokemon AppTests
//
//  Created by Emre Aydin on 6.10.2023.
//

import Foundation
import XCTest
import RxSwift
@testable import Pokemon_App

class SearchViewControllerTest: XCTestCase {
    private let disposeBag = DisposeBag()

    var viewModel: SearchViewModelInput?
    var repository: CardRepository?
    
    func test_WhenAPIRequestSucceed_CardResultShouldEmitted() {
        let expectation = XCTestExpectation(description: "CardsResult")

        guard let cardsResult = MockDataManager.getData(from: "mock_cards_result", type: CardsResult.self) else {
            // Fail the test, as the JSON file can not be parsed into CardsResult
            XCTAssertTrue(false)
            return
        }

        repository = CardRepositoryMock(cardsResult)
        viewModel = SearchViewModel(repository: repository!)

        viewModel?.searchResultDidChange.subscribe { result in
            guard let data = result.element else {
                fatalError("No data returned, please check test.")
            }
            
            XCTAssertNotNil(data.cards)
            XCTAssertGreaterThan(data.cards?.count ?? 0, 0)
            expectation.fulfill()
        }.disposed(by: disposeBag)
        
        viewModel?.fetchSearchResults(hp: 0)

        wait(for: [expectation], timeout: 5.0)
    }
}
