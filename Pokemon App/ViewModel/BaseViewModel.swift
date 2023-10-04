//
//  BaseViewModel.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import RxSwift

protocol BaseViewModel {
    var isLoading: ReplaySubject<Bool> { get set }
}
