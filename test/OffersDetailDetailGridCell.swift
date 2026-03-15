//
//  OffersDetailDetailGridCell.swift
//  test
//
//  Created by Cursor on 2026/3/12.
//

import UIKit
import SnapKit

final class OffersDetailDetailGridCell: UITableViewCell {

    static let reuseIdentifier = "OffersDetailDetailGridCell"

    private let sectionInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    private let itemSpacing: CGFloat = 8
    private var cards: [OffersDetailTierCardModel] = []
    private var maxCardHeight: CGFloat = 0

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = itemSpacing
        return layout
    }()

    private lazy var collectionContainerView: OffersDetailCollectionContainerView = {
        let view = OffersDetailCollectionContainerView(collectionViewLayout: flowLayout)
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        view.collectionView.register(
            OffersDetailInfoCardCollectionCell.self,
            forCellWithReuseIdentifier: OffersDetailInfoCardCollectionCell.reuseIdentifier
        )
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(cards: [OffersDetailTierCardModel]) {
        self.cards = cards
        maxCardHeight = cards.map {
            OffersDetailInfoCardCollectionCell.preferredHeight(for: $0)
        }.max() ?? 0
        flowLayout.invalidateLayout()
        collectionContainerView.configure(
            .init(
                height: maxCardHeight,
                contentInset: sectionInsets,
                scrollIndicatorInsets: sectionInsets,
                showsHorizontalScrollIndicator: false,
                showsVerticalScrollIndicator: false
            )
        )
        collectionContainerView.collectionView.reloadData()
    }
}

// MARK: - Private
private extension OffersDetailDetailGridCell {

    func setupUI() {
        contentView.addSubview(collectionContainerView)

        collectionContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension OffersDetailDetailGridCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OffersDetailInfoCardCollectionCell.reuseIdentifier,
            for: indexPath
        ) as! OffersDetailInfoCardCollectionCell
        cell.configure(model: cards[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OffersDetailDetailGridCell: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = OffersDetailInfoCardCollectionCell.preferredWidth
        return CGSize(width: width, height: maxCardHeight)
    }
}
