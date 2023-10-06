//
//  CardDetailViewController.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation
import UIKit
import RxSwift

// MARK: CardDetailViewController
class CardDetailViewController: BaseViewController {
    private let disposeBag = DisposeBag()

    // MARK: Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var hpLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    
    // MARK: MVVM-C Components
    var viewModel: CardDetailViewModelInput? {
        get { baseVM as? CardDetailViewModelInput }
        set { baseVM = newValue}
    }

    // MARK: Data
    private var cardID: String?
    private var card: Card? {
        didSet {
            guard let card else { return }

            self.imageView.loadImageFromUrl(card.imageURLHiRes)
            
            self.titleLabel.text = card.name ?? ""
            self.hpLabel.text = "HP: \(card.hp ?? "")"
            self.artistNameLabel.text = "Artist: \(card.artist ?? "")"
        }
    }

    static func instance(withCard card: Card) -> CardDetailViewController? {
        let controller = instance(fromName: "CardDetailView")
        controller?.cardID = card.id

        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        
        guard let cardID else { return }
        viewModel?.fetchCard(cardID)
    }
    
    private func setObservers() {
        viewModel?.cardResultDidChange.subscribe { [weak self] result in
            guard let self,
                  let card = result.element?.card else { return }

            self.card = card
        }.disposed(by: disposeBag)
    }
}

// MARK: Configuration
private extension CardDetailViewController{
    final func configureUI() {
        title = "Details"
        
        configureLabels()
    }
    
    final func configureLabels() {
        self.titleLabel.text = ""
        self.hpLabel.text = ""
        self.artistNameLabel.text = ""
    }
}
