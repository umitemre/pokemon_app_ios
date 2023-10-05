//
//  CardsViewCell.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import UIKit

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
    
    weak var delegate: CardsViewDelegate?

    override func awakeFromNib() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.addGestureRecognizer(longPressRecognizer)
    }
}

// MARK: Actions
extension CardsViewCell {
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            delegate?.didLongPressItem(self.card)
        }
    }
}

// MARK: Public
extension CardsViewCell {
    final func setData(_ card: Card?) {
        self.card = card
    }
}
