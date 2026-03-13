//
//  OffersDetailSummaryCell.swift
//  test
//
//  Created by Cursor on 2026/3/12.
//

import UIKit
import SnapKit

final class OffersDetailSummaryCell: UITableViewCell {

    enum SeeMoreState: Equatable {
        case plain
        case collapsed
        case expanded
    }

    static let reuseIdentifier = "OffersDetailSummaryCell"
    var onSeeMoreTap: ((OffersDetailSummaryCell) -> Void)?
    private var seeMoreTopConstraint: Constraint?
    private var seeMoreHeightConstraint: Constraint?

    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 96 / 255, green: 98 / 255, blue: 102 / 255, alpha: 1)
        label.numberOfLines = 3
        return label
    }()

    private lazy var seeMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See more", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(handleSeeMoreTap), for: .touchUpInside)
        return button
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

    override func prepareForReuse() {
        super.prepareForReuse()
        onSeeMoreTap = nil
    }

    func configure(title: String, subtitle: String, state: SeeMoreState) {
        titleLabel.text = title
        subtitleLabel.text = subtitle

        switch state {
        case .plain:
            subtitleLabel.numberOfLines = 0
            seeMoreButton.isHidden = true
            seeMoreTopConstraint?.update(offset: 0)
            seeMoreHeightConstraint?.update(offset: 0)
        case .collapsed:
            subtitleLabel.numberOfLines = 3
            seeMoreButton.isHidden = false
            seeMoreTopConstraint?.update(offset: 4)
            seeMoreHeightConstraint?.update(offset: 18)
            seeMoreButton.setTitle("See more", for: .normal)
        case .expanded:
            subtitleLabel.numberOfLines = 0
            seeMoreButton.isHidden = false
            seeMoreTopConstraint?.update(offset: 4)
            seeMoreHeightConstraint?.update(offset: 18)
            seeMoreButton.setTitle("See less", for: .normal)
        }
    }
}

// MARK: - Private
private extension OffersDetailSummaryCell {

    @objc
    func handleSeeMoreTap() {
        onSeeMoreTap?(self)
    }

    func setupUI() {
        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(subtitleLabel)
        cardView.addSubview(seeMoreButton)

        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }

        seeMoreButton.snp.makeConstraints { make in
            seeMoreTopConstraint = make.top.equalTo(subtitleLabel.snp.bottom).offset(4).constraint
            make.leading.equalToSuperview()
            seeMoreHeightConstraint = make.height.equalTo(18).constraint
            make.bottom.equalToSuperview()
        }
    }
}
