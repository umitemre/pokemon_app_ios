//
//  CardsView.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import UIKit

// MARK: CardsView
class CardsView: UIView {
    private typealias Cell = CardsViewCell

    // MARK: Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Contants
    private let cellWidth: CGFloat = 120
    private let cellHeight: CGFloat = 232

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        configureUI()
    }
}

// MARK: Init
private extension CardsView {
    final func commonInit() {
        let view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}

// MARK: Configuration
private extension CardsView {
    final func configureUI() {
        configureCollectionView()
    }

    final func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8

        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(UINib(nibName: Cell.identifier, bundle: nil), forCellWithReuseIdentifier: Cell.identifier)

        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CardsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension CardsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("Can't dequeued reusable cell: \(Cell.identifier)")
        }

        return cell
    }
}
