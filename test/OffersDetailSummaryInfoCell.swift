//
//  OffersDetailSummaryInfoCell.swift
//  test
//
//  Created by Cursor on 2026/3/13.
//

import UIKit
import SnapKit

final class OffersDetailSummaryInfoCell: UITableViewCell {

    static let reuseIdentifier = "OffersDetailSummaryInfoCell"

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var validRowView = OffersDetailSummaryInfoRowView()
    private lazy var locationRowView = OffersDetailSummaryInfoRowView()
    private lazy var merchantRowView = OffersDetailSummaryMerchantRowView()

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

    func configure(dateText: String, venue: String, merchantText: String) {
        validRowView.configure(title: "Valid Date", value: dateText)
        locationRowView.configure(title: "Location", value: venue)
        merchantRowView.configure(title: "Applicable Merchants", merchantText: merchantText)
    }
}

private extension OffersDetailSummaryInfoCell {

    func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(validRowView)
        containerView.addSubview(locationRowView)
        containerView.addSubview(merchantRowView)

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }

        validRowView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        locationRowView.snp.makeConstraints { make in
            make.top.equalTo(validRowView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        merchantRowView.snp.makeConstraints { make in
            make.top.equalTo(locationRowView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(46)
            make.bottom.equalToSuperview()
        }
    }
}

private final class OffersDetailSummaryInfoRowView: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(red: 96 / 255, green: 98 / 255, blue: 102 / 255, alpha: 1)
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}

private extension OffersDetailSummaryInfoRowView {

    func setupUI() {
        backgroundColor = UIColor(red: 240 / 255, green: 242 / 255, blue: 245 / 255, alpha: 1)
        layer.cornerRadius = 12

        addSubview(titleLabel)
        addSubview(valueLabel)

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }

        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(18)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(12)
        }

        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}

private final class OffersDetailSummaryMerchantRowView: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(red: 96 / 255, green: 98 / 255, blue: 102 / 255, alpha: 1)
        return label
    }()

    private lazy var tagContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.35)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 206 / 255, green: 210 / 255, blue: 216 / 255, alpha: 1).cgColor
        return view
    }()

    private lazy var merchantLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, merchantText: String) {
        titleLabel.text = title
        merchantLabel.text = merchantText
    }
}

private extension OffersDetailSummaryMerchantRowView {

    func setupUI() {
        backgroundColor = UIColor(red: 240 / 255, green: 242 / 255, blue: 245 / 255, alpha: 1)
        layer.cornerRadius = 12

        addSubview(titleLabel)
        addSubview(tagContainerView)
        addSubview(chevronImageView)
        tagContainerView.addSubview(merchantLabel)

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.centerY.equalToSuperview()
        }

        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(18)
            make.width.height.equalTo(16)
        }

        tagContainerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-10)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(12)
            make.height.equalTo(32)
        }

        merchantLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }

        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        tagContainerView.setContentCompressionResistancePriority(.required, for: .horizontal)
        chevronImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
