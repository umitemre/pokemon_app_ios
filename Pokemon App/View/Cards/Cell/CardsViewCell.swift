//
//  CardsViewCell.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import UIKit

class CardsViewCell: UICollectionViewCell {
    // MARK: Outlets
    @IBOutlet private weak var favoriteImageView: UIImageView!
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
    private var isFavorited = false {
        didSet {
            favoriteImageView.isHidden = !isFavorited
        }
    }
    
    weak var delegate: CardsViewDelegate?

    override func awakeFromNib() {
        configureUI()
    }
}

// MARK: Configuration
private extension CardsViewCell {
    final func configureUI() {
        configureLongPress()
        configureFavoriteImage()
    }
    
    final func configureLongPress() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    final func configureFavoriteImage() {
        favoriteImageView.isHidden = true
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
    final func setData(_ card: Card?, isFavorited: Bool) {
        self.card = card
        self.isFavorited = isFavorited
    }
}
