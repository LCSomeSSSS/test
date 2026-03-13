//
//  OffersDetailActionCell.swift
//  test
//
//  Created by Cursor on 2026/3/12.
//

import UIKit
import SnapKit

final class OffersDetailActionCell: UITableViewCell {

    static let reuseIdentifier = "OffersDetailActionCell"
    private let hintGradientLayer = CAGradientLayer()

    private enum Palette {
        static let hintBorder = UIColor(red: 255 / 255, green: 238 / 255, blue: 204 / 255, alpha: 1)
        static let titleText = UIColor(red: 94 / 255, green: 65 / 255, blue: 8 / 255, alpha: 1)
        static let bodyText = UIColor(red: 96 / 255, green: 98 / 255, blue: 102 / 255, alpha: 1)
        static let buttonBackground = UIColor(red: 244 / 255, green: 226 / 255, blue: 190 / 255, alpha: 1)
        static let buttonBorder = UIColor(red: 236 / 255, green: 207 / 255, blue: 147 / 255, alpha: 1)
        static let buttonText = UIColor(red: 95 / 255, green: 71 / 255, blue: 34 / 255, alpha: 1)
        static let shadow = UIColor(red: 31 / 255, green: 37 / 255, blue: 51 / 255, alpha: 0.05)
        static let gradientTop = UIColor(red: 255 / 255, green: 246 / 255, blue: 229 / 255, alpha: 1)
    }

    private lazy var hintContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = Palette.hintBorder.cgColor
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var lockLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = Palette.titleText
        label.textAlignment = .left
        label.text = "🔒"
        return label
    }()

    private lazy var hintTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Palette.titleText
        label.text = "Log In To Check Your Access!"
        return label
    }()

    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Palette.bodyText
        label.numberOfLines = 0
        return label
    }()

    private lazy var primaryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(Palette.buttonText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.backgroundColor = Palette.buttonBackground
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = Palette.buttonBorder.cgColor
        button.layer.shadowColor = Palette.shadow.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 20
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.isUserInteractionEnabled = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupGradient()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        hintGradientLayer.frame = hintContainerView.bounds
        hintGradientLayer.cornerRadius = hintContainerView.layer.cornerRadius
        primaryButton.layer.shadowPath = UIBezierPath(
            roundedRect: primaryButton.bounds,
            cornerRadius: primaryButton.layer.cornerRadius
        ).cgPath
    }

    func configure(hintText: String, primaryTitle: String) {
        hintLabel.text = hintText
        primaryButton.setTitle(primaryTitle, for: .normal)
    }
}

// MARK: - Private
private extension OffersDetailActionCell {

    func setupGradient() {
        hintGradientLayer.colors = [
            Palette.gradientTop.cgColor,
            UIColor.white.cgColor,
            UIColor.white.cgColor
        ]
        hintGradientLayer.locations = [0, 0.4364, 1]
        hintGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        hintGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        hintContainerView.layer.insertSublayer(hintGradientLayer, at: 0)
    }

    func setupUI() {
        contentView.addSubview(hintContainerView)
        hintContainerView.addSubview(lockLabel)
        hintContainerView.addSubview(hintTitleLabel)
        hintContainerView.addSubview(hintLabel)
        hintContainerView.addSubview(primaryButton)

        hintContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }

        lockLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(14)
            make.width.height.equalTo(20)
        }

        hintTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(lockLabel)
            make.leading.equalTo(lockLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(14)
        }

        hintLabel.snp.makeConstraints { make in
            make.top.equalTo(hintTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(lockLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(14)
        }

        primaryButton.snp.makeConstraints { make in
            make.top.equalTo(hintLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(14)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(14)
        }
    }
}
