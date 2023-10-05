//
//  CardsViewCell.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import UIKit

// MARK: CardsViewCell
class CardsViewCell: UICollectionViewCell {
    // MARK: Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var hpLabel: UILabel!
    
    // MARK: Data
    private var card: Card? {
        didSet {
            guard let imageURL = card?.imageURL else { return }
            imageView.loadImageFromUrl(imageURL)

            titleLabel.text = card?.name ?? ""
            hpLabel.text = "HP: \(card?.hp ?? "")"
        }
    }
}

// MARK: Public
extension CardsViewCell {
    final func setData(_ card: Card?) {
        self.card = card
    }
}
