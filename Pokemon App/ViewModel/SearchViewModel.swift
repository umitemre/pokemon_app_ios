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
    var recentlyViewedDidChanged: Observable<[Card]> { get }

    func subscribeToRecentlyViewed()
    func fetchSearchResults(hp: Int)
    func retryLastSearch()
}

// MARK: SearchViewModel
class SearchViewModel: BaseViewModel, SearchViewModelInput {
    private var _searchResultDidChange: ReplaySubject<CardsResult> = ReplaySubject.create(bufferSize: 1)
    var searchResultDidChange: RxSwift.Observable<CardsResult> {
        get {
            return _searchResultDidChange
        }
    }

    private var _searchResultError: ReplaySubject<Error> = ReplaySubject.create(bufferSize: 1)
    var searchResultError: RxSwift.Observable<Error> {
        get {
            return _searchResultError
        }
    }
    
    private var _recentlyViewedDidChanged: ReplaySubject<[Card]> = ReplaySubject.create(bufferSize: 1)
    var recentlyViewedDidChanged: Observable<[Card]> {
        get {
            return _recentlyViewedDidChanged
        }
    }

    private var lastHPQuery: Int?
    private let repository: CardRepository
    private let recentlyViewedManager = RecentlyViewedManager.shared
    
    init(repository: CardRepository) {
        self.repository = repository
    }
}

// MARK: Public
extension SearchViewModel {
    final func subscribeToRecentlyViewed() {
        recentlyViewedManager.triggerRecentlyViewedUpdate()
        recentlyViewedManager.recentlyViewed.subscribe { [weak self] data in
            guard let self,
                  let results = data.element else { return }
            
            self._recentlyViewedDidChanged.onNext(results.toCards.reversed())
        }.disposed(by: disposeBag)
    }

    final func fetchSearchResults(hp: Int) {
        self.lastHPQuery = hp

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
        guard let lastHPQuery else { return }

        fetchSearchResults(hp: lastHPQuery)
    }
}
