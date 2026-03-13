//
//  OffersDetailInfoCardCollectionCell.swift
//  test
//
//  Created by Cursor on 2026/3/12.
//

import UIKit
import SnapKit

final class OffersDetailInfoCardCollectionCell: UICollectionViewCell {

    static let reuseIdentifier = "OffersDetailInfoCardCollectionCell"
    static let preferredWidth = OffersDetailTierCardLayout.preferredWidth

    private lazy var tierCardView = OffersDetailTierCardView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        tierCardView.reset()
    }

    static func preferredHeight(for model: OffersDetailTierCardModel, width: CGFloat = preferredWidth) -> CGFloat {
        OffersDetailTierCardLayout.preferredHeight(for: model, width: width)
    }

    func configure(model: OffersDetailTierCardModel) {
        tierCardView.apply(model: model)
    }
}

// MARK: - Private
private extension OffersDetailInfoCardCollectionCell {

    func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(tierCardView)

        tierCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
