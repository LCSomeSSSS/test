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
    private var items: [(String, String, UIColor)] = []

    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

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

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = itemSpacing
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = sectionInsets
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            OffersDetailRelatedOfferCollectionCell.self,
            forCellWithReuseIdentifier: OffersDetailRelatedOfferCollectionCell.reuseIdentifier
        )
        return collectionView
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

    func configure(title: String, items: [(String, String, UIColor)]) {
        titleLabel.text = title
        self.items = items
        collectionView.reloadData()
    }
}

// MARK: - Private
private extension OffersDetailRelatedOffersCell {

    func setupUI() {
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(collectionView)
        cardView.addSubview(dividerView)

        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }

        dividerView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
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
        cell.configure(title: item.0, subtitle: item.1, color: item.2)
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
