//
//  OffersDetailCollectionContainerView.swift
//  test
//
//  Created by Cursor on 2026/3/13.
//

import UIKit
import SnapKit

final class OffersDetailCollectionContainerView: UIView {

    struct Configuration {
        let height: CGFloat
        let contentInset: UIEdgeInsets
        let scrollIndicatorInsets: UIEdgeInsets
        let showsHorizontalScrollIndicator: Bool
        let showsVerticalScrollIndicator: Bool

        init(
            height: CGFloat,
            contentInset: UIEdgeInsets = .zero,
            scrollIndicatorInsets: UIEdgeInsets = .zero,
            showsHorizontalScrollIndicator: Bool = false,
            showsVerticalScrollIndicator: Bool = false
        ) {
            self.height = height
            self.contentInset = contentInset
            self.scrollIndicatorInsets = scrollIndicatorInsets
            self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
            self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        }
    }

    let collectionView: UICollectionView

    private var collectionHeightConstraint: Constraint?

    init(collectionViewLayout: UICollectionViewLayout) {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ configuration: Configuration) {
        collectionView.contentInset = configuration.contentInset
        collectionView.scrollIndicatorInsets = configuration.scrollIndicatorInsets
        collectionView.showsHorizontalScrollIndicator = configuration.showsHorizontalScrollIndicator
        collectionView.showsVerticalScrollIndicator = configuration.showsVerticalScrollIndicator
        collectionHeightConstraint?.update(offset: configuration.height)
    }
}

// MARK: - Private
private extension OffersDetailCollectionContainerView {

    func setupUI() {
        backgroundColor = .clear
        collectionView.backgroundColor = .clear

        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            collectionHeightConstraint = make.height.equalTo(0).constraint
        }
    }
}
