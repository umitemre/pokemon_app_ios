//
//  BaseViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 4.10.2023.
//

import UIKit

// MARK: StoryboardInstantiable
protocol StoryboardInstantiable {
    static func instance(fromName name: String) -> Self?
}

// MARK: BaseViewController
class BaseViewController: UIViewController {

}

// MARK: StoryboardInstantiable
extension BaseViewController: StoryboardInstantiable {
    static func instance(fromName name: String) -> Self? {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return instance(fromStoryboard: storyboard)
    }

    private static func instance(fromStoryboard storyboard: UIStoryboard) -> Self? {
        return storyboard.instantiateViewController(identifier: String(describing: Self.self)) as? Self
    }
}
