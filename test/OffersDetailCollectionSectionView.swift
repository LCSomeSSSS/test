//
//  OffersDetailCollectionSectionView.swift
//  test
//
//  Created by Cursor on 2026/3/13.
//

import UIKit
import SnapKit

final class OffersDetailCollectionSectionView: UIView {

    struct Configuration {
        let title: String
        let collectionConfiguration: OffersDetailCollectionContainerView.Configuration
        let showsDivider: Bool
        let topInset: CGFloat
        let collectionTopSpacing: CGFloat
        let dividerTopSpacing: CGFloat

        init(
            title: String,
            collectionConfiguration: OffersDetailCollectionContainerView.Configuration,
            showsDivider: Bool = true,
            topInset: CGFloat = 0,
            collectionTopSpacing: CGFloat = 10,
            dividerTopSpacing: CGFloat = 12
        ) {
            self.title = title
            self.collectionConfiguration = collectionConfiguration
            self.showsDivider = showsDivider
            self.topInset = topInset
            self.collectionTopSpacing = collectionTopSpacing
            self.dividerTopSpacing = dividerTopSpacing
        }
    }

    private var dividerHeightConstraint: Constraint?
    private var dividerTopConstraint: Constraint?
    private var titleTopConstraint: Constraint?
    private var collectionTopConstraint: Constraint?

    private lazy var collectionContainerView: OffersDetailCollectionContainerView = {
        OffersDetailCollectionContainerView(collectionViewLayout: collectionViewLayout)
    }()

    private let collectionViewLayout: UICollectionViewLayout

    var collectionView: UICollectionView {
        collectionContainerView.collectionView
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 236 / 255, green: 236 / 255, blue: 236 / 255, alpha: 1)
        return view
    }()

    init(collectionViewLayout: UICollectionViewLayout) {
        self.collectionViewLayout = collectionViewLayout
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(_ configuration: Configuration) {
        titleLabel.text = configuration.title
        titleTopConstraint?.update(offset: configuration.topInset)
        collectionTopConstraint?.update(offset: configuration.collectionTopSpacing)
        collectionContainerView.configure(configuration.collectionConfiguration)

        if configuration.showsDivider {
            dividerView.isHidden = false
            dividerHeightConstraint?.update(offset: 0.5)
            dividerTopConstraint?.update(offset: configuration.dividerTopSpacing)
        } else {
            dividerView.isHidden = true
            dividerHeightConstraint?.update(offset: 0)
            dividerTopConstraint?.update(offset: 0)
        }
    }
}

// MARK: - Private
private extension OffersDetailCollectionSectionView {

    func setupUI() {
        backgroundColor = .clear

        addSubview(titleLabel)
        addSubview(collectionContainerView)
        addSubview(dividerView)

        titleLabel.snp.makeConstraints { make in
            titleTopConstraint = make.top.equalToSuperview().offset(0).constraint
            make.leading.trailing.equalToSuperview()
        }

        collectionContainerView.snp.makeConstraints { make in
            collectionTopConstraint = make.top.equalTo(titleLabel.snp.bottom).offset(10).constraint
            make.leading.trailing.equalToSuperview()
        }

        dividerView.snp.makeConstraints { make in
            dividerTopConstraint = make.top.equalTo(collectionContainerView.snp.bottom).offset(12).constraint
            make.leading.trailing.equalToSuperview()
            dividerHeightConstraint = make.height.equalTo(0.5).constraint
            make.bottom.equalToSuperview()
        }
    }
}
