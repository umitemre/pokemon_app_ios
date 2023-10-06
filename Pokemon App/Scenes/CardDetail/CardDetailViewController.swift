//
//  CardDetailViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation
import UIKit

// MARK: CardDetailViewController
class CardDetailViewController: BaseViewController {
    // MARK: Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var hpLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    
    // MARK: Data
    private var card: Card?

    static func instance(withCard card: Card) -> CardDetailViewController? {
        let controller = instance(fromName: "CardDetailView")
        controller?.card = card

        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: Configuration
private extension CardDetailViewController{
    final func configureUI() {
        title = "Details"
        bindData()
    }
    
    final func bindData() {
        self.imageView.loadImageFromUrl(card?.imageURLHiRes)
        
        self.titleLabel.text = card?.name ?? ""
        self.hpLabel.text = "HP: \(card?.hp ?? "")"
        self.artistNameLabel.text = "Artist: \(card?.artist ?? "")"
    }
}
