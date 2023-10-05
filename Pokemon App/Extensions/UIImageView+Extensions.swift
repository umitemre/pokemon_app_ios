//
//  UIImageView+Extensions.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation
import AlamofireImage
import UIKit

extension UIImageView {
    func loadImageFromUrl(_ path: String?) {
        guard let path = path else { return }
        self.loadImageFromUrl(URL(string: path))
    }
    
    func loadImageFromUrl(_ url: URL?) {
        guard let url = url else { return }
        self.image = nil
        self.af.setImage(withURL: url)
    }
}
