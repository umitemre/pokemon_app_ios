//
//  CardDetailViewModel.swift
//  Pokemon App
//
//  Created by Emre Aydin on 6.10.2023.
//

import Foundation
import RxSwift

// MARK: CardDetailViewModelInput
protocol CardDetailViewModelInput: BaseViewModel {
    var cardResultDidChange: Observable<CardResult> { get }
    var cardResultError: Observable<Error> { get }
    func fetchCard(_ id: String)
}

// MARK: CardDetailViewModel
class CardDetailViewModel: CardDetailViewModelInput {
    private var _cardResultDidChange: ReplaySubject<CardResult> = ReplaySubject.create(bufferSize: 1)
    var cardResultDidChange: RxSwift.Observable<CardResult> {
        get {
            return _cardResultDidChange
        }
    }

    private var _cardResultError: ReplaySubject<Error> = ReplaySubject.create(bufferSize: 1)
    var cardResultError: RxSwift.Observable<Error> {
        get {
            return _cardResultError
        }
    }

    var isLoading: RxSwift.ReplaySubject<Bool> = ReplaySubject.create(bufferSize: 1)
    
    private let repository: CardRepository
    
    init(repository: CardRepository) {
        self.repository = repository
    }
}

// MARK: Public
extension CardDetailViewModel {
    final func fetchCard(_ id: String) {
        isLoading.onNext(true)
        repository.fetchCard(id: id) { [weak self] result in
            guard let self else { return }
            
            self.isLoading.onNext(false)
            switch result {
            case .success(let data):
                self._cardResultDidChange.onNext(data)
            case .failure(let error):
                self._cardResultError.onNext(error)
            }
        }
    }
}
