//
//  SearchViewModel.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation
import RxSwift

// MARK: SearchViewModelInput
protocol SearchViewModelInput: BaseViewModelProtocol {
    var searchResultDidChange: Observable<CardsResult> { get }
    var searchResultError: Observable<Error> { get }
    
    func fetchSearchResults(hp: Int)
    func retryLastSearch()
}

// MARK: SearchViewModel
class SearchViewModel: BaseViewModel, SearchViewModelInput {
    var _searchResultDidChange: ReplaySubject<CardsResult> = ReplaySubject.create(bufferSize: 1)
    var searchResultDidChange: RxSwift.Observable<CardsResult> {
        get {
            return _searchResultDidChange
        }
    }

    var _searchResultError: ReplaySubject<Error> = ReplaySubject.create(bufferSize: 1)
    var searchResultError: RxSwift.Observable<Error> {
        get {
            return _searchResultError
        }
    }
    
    var hp: Int?

    private let repository: CardRepository
    
    init(repository: CardRepository) {
        self.repository = repository
    }
}

// MARK: Public
extension SearchViewModel {
    final func fetchSearchResults(hp: Int) {
        self.hp = hp

        isLoading.onNext(true)
        repository.fetchCards(hp: hp) { [weak self] result in
            guard let self else { return }
            
            self.isLoading.onNext(false)

            switch result {
            case .success(let data):
                self._searchResultDidChange.onNext(data)
            case .failure(let error):
                self._searchResultError.onNext(error)
            }
        }
    }
    
    final func retryLastSearch() {
        guard let hp else { return }

        fetchSearchResults(hp: hp)
    }
}
