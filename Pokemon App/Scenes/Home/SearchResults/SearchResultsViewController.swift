//
//  SearchResultsViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation

class SearchResultsViewController: BaseViewController {
    static func instance() -> SearchResultsViewController? {
        return instance(fromName: "SearchResults")
    }
}
