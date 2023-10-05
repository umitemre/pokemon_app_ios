//
//  CardsViewCell.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import UIKit

class CardsViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var hpLabel: UILabel!
    
    override func awakeFromNib() {
        imageView.loadImageFromUrl("https://images.pokemontcg.io/swsh4/175.png")
    }
}
