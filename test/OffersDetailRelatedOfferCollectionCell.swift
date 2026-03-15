//
//  OffersDetailRelatedOfferCollectionCell.swift
//  test
//
//  Created by Cursor on 2026/3/12.
//

import UIKit
import SnapKit

final class OffersDetailRelatedOfferCollectionCell: UICollectionViewCell {

    static let reuseIdentifier = "OffersDetailRelatedOfferCollectionCell"

    private lazy var cardView = OffersDetailRelatedOfferCardView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(item: OffersDetailRelatedOfferItem) {
        cardView.configure(item: item)
    }
}

// MARK: - Private
private extension OffersDetailRelatedOfferCollectionCell {

    func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
