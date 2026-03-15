//
//  OffersDetailQualifiedOfferCell.swift
//  test
//
//  Created by Cursor on 2026/3/13.
//

import UIKit
import SnapKit

final class OffersDetailQualifiedOfferCell: UITableViewCell {

    static let reuseIdentifier = "OffersDetailQualifiedOfferCell"

    private enum Palette {
        static let cardBackground = UIColor(red: 240 / 255, green: 242 / 255, blue: 245 / 255, alpha: 1)
        static let titleText = UIColor(red: 46 / 255, green: 48 / 255, blue: 51 / 255, alpha: 1)
        static let bodyText = UIColor.black.withAlphaComponent(0.7)
        static let placeholder = UIColor(red: 217 / 255, green: 217 / 255, blue: 217 / 255, alpha: 1)
    }

    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = Palette.cardBackground
        view.layer.cornerRadius = 20
        return view
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thumbnailView, textStackView])
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 12
        return stackView
    }()

    private lazy var thumbnailView: UIView = {
        let view = UIView()
        view.backgroundColor = Palette.placeholder
        view.layer.cornerRadius = 2
        return view
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 6
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Palette.titleText
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Palette.bodyText
        label.numberOfLines = 0
        return label
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

    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

// MARK: - Private
private extension OffersDetailQualifiedOfferCell {

    func setupUI() {
        contentView.addSubview(cardView)
        cardView.addSubview(contentStackView)

        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }

        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(14)
        }

        thumbnailView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
    }
}
