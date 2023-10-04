//
//  HomeViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import Foundation

class HomeViewController: BaseViewController {
    //MARK: MVVM-C Component
    var coordinator: HomeCoordinator? {
        get { baseCoordinator as? HomeCoordinator }
        set { baseCoordinator = newValue }
    }

    static func instance() -> HomeViewController? {
        return HomeViewController.instance(fromName: "Home")
    }
}
