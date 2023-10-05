//
//  UIView.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import UIKit

protocol NibLoadable {
    func loadFromNib() -> UIView
}

extension UIView {
    static var identifier: String {
        String(describing: Self.self)
    }
}

extension UIView: NibLoadable {
    func loadFromNib() -> UIView {
        let nibName = String(describing: Self.self)
        return loadFromNib(fileName: nibName)
    }

    private func loadFromNib(fileName name: String) -> UIView {
        guard let view = Bundle.main.loadNibNamed(name, owner: self, options: nil)?[0] as? UIView else {
            fatalError("Can't instantiate NIB file")
        }

        return view
    }
}
