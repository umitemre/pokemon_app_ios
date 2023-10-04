//
//  SearchViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

class SearchViewController: BaseViewController {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    }

    static func instance() -> SearchViewController? {
        return instance(fromName: "Search")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
