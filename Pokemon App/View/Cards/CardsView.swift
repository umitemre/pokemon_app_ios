//
//  CardsView.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import UIKit

// MARK: CardsViewCell
protocol CardsViewDelegate: AnyObject {
    func didTapItem(_ card: Card?)
    func didLongPressItem(_ card: Card?)
}

// MARK: CardsView
class CardsView: UIView {
    private typealias Cell = CardsViewCell

    // MARK: Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Contants
    private let cellWidth: CGFloat = 120
    private let cellHeight: CGFloat = 232
    
    weak var delegate: CardsViewDelegate?
    
    // MARK: Data
    private var cardsResult: CardsResult? {
        didSet {
            reloadData()
        }
    }

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

// MARK: Public
extension CardsView {
    final func setCardsResult(_ cardsResults: CardsResult?) {
        self.cardsResult = cardsResults
    }
    
    final func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CardsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = cardsResult?.cards?[indexPath.row] else { return }
        delegate?.didTapItem(data)
    }
}

// MARK: UICollectionViewDataSource
extension CardsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsResult?.cards?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("Can't dequeued reusable cell: \(Cell.identifier)")
        }
        
        let data = cardsResult?.cards?[indexPath.row]
        let isFavorited = FavoritesManager.shared.doesFavoriteExist(data?.id)
        cell.delegate = delegate
        cell.setData(data, isFavorited: isFavorited)

        return cell
    }
}
