//
//  OffersDetailRelatedOffersCell.swift
//  test
//
//  Created by Cursor on 2026/3/12.
//

import UIKit
import SnapKit

final class OffersDetailRelatedOffersCell: UITableViewCell {

    static let reuseIdentifier = "OffersDetailRelatedOffersCell"

    private let sectionInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    private let itemSpacing: CGFloat = 8
    private var items: [OffersDetailRelatedOfferItem] = []

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = itemSpacing
        return layout
    }()

    private lazy var sectionView: OffersDetailCollectionSectionView = {
        let view = OffersDetailCollectionSectionView(collectionViewLayout: flowLayout)
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        view.collectionView.register(
            OffersDetailRelatedOfferCollectionCell.self,
            forCellWithReuseIdentifier: OffersDetailRelatedOfferCollectionCell.reuseIdentifier
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

    func configure(title: String, items: [OffersDetailRelatedOfferItem]) {
        self.items = items
        sectionView.configure(
            .init(
                title: title,
                collectionConfiguration: .init(
                    height: 160,
                    contentInset: sectionInsets,
                    scrollIndicatorInsets: sectionInsets,
                    showsHorizontalScrollIndicator: false,
                    showsVerticalScrollIndicator: false
                ),
                showsDivider: true,
                topInset: 0,
                collectionTopSpacing: 10,
                dividerTopSpacing: 12
            )
        )
        sectionView.collectionView.reloadData()
    }
}

// MARK: - Private
private extension OffersDetailRelatedOffersCell {

    func setupUI() {
        contentView.addSubview(sectionView)
        sectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension OffersDetailRelatedOffersCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OffersDetailRelatedOfferCollectionCell.reuseIdentifier,
            for: indexPath
        ) as! OffersDetailRelatedOfferCollectionCell
        let item = items[indexPath.item]
        cell.configure(item: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OffersDetailRelatedOffersCell: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 100, height: 160)
    }
}
