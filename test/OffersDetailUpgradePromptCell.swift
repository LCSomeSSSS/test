//
//  OffersDetailUpgradePromptCell.swift
//  test
//
//  Created by Cursor on 2026/3/13.
//

import UIKit
import SnapKit

final class OffersDetailUpgradePromptCell: UITableViewCell {

    struct UpgradeMethod {
        let icon: UIImage?
        let title: String
    }

    static let reuseIdentifier = "OffersDetailUpgradePromptCell"

    private enum Palette {
        static let cardBorder = UIColor(red: 255 / 255, green: 238 / 255, blue: 204 / 255, alpha: 1)
        static let titleText = UIColor(red: 94 / 255, green: 65 / 255, blue: 8 / 255, alpha: 1)
        static let bodyText = UIColor(red: 96 / 255, green: 98 / 255, blue: 102 / 255, alpha: 1)
        static let methodBackground = UIColor(white: 1, alpha: 0.75)
        static let iconBackground = UIColor(red: 250 / 255, green: 245 / 255, blue: 235 / 255, alpha: 1)
        static let methodText = UIColor(red: 109 / 255, green: 87 / 255, blue: 44 / 255, alpha: 1)
        static let divider = UIColor.black.withAlphaComponent(0.05)
        static let shadow = UIColor(red: 31 / 255, green: 37 / 255, blue: 51 / 255, alpha: 0.05)
        static let gradientTop = UIColor(red: 255 / 255, green: 246 / 255, blue: 229 / 255, alpha: 1)
    }

    private let cardGradientLayer = CAGradientLayer()

    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = Palette.cardBorder.cgColor
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var topRowStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [lockImageView, titleTextStackView])
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 8
        return stackView
    }()

    private lazy var lockImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "lock.fill"))
        imageView.tintColor = Palette.titleText
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        return imageView
    }()

    private lazy var titleTextStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
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

    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Palette.divider
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Palette.bodyText
        label.numberOfLines = 0
        return label
    }()

    private lazy var methodsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
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
        cardGradientLayer.frame = cardView.bounds
        cardGradientLayer.cornerRadius = cardView.layer.cornerRadius
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        methodsStackView.arrangedSubviews.forEach { view in
            methodsStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    func configure(
        title: String,
        subtitle: String,
        description: String,
        methods: [UpgradeMethod]
    ) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        descriptionLabel.text = description

        methodsStackView.arrangedSubviews.forEach { view in
            methodsStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        methods.forEach { method in
            methodsStackView.addArrangedSubview(makeMethodView(for: method))
        }
    }
}

// MARK: - Private
private extension OffersDetailUpgradePromptCell {

    func setupGradient() {
        cardGradientLayer.colors = [
            Palette.gradientTop.cgColor,
            UIColor.white.cgColor
        ]
        cardGradientLayer.locations = [0, 0.4364]
        cardGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        cardGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        cardView.layer.insertSublayer(cardGradientLayer, at: 0)
    }

    func setupUI() {
        contentView.addSubview(cardView)
        cardView.addSubview(topRowStackView)
        cardView.addSubview(dividerView)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(methodsStackView)

        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }

        topRowStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(14)
        }

        dividerView.snp.makeConstraints { make in
            make.top.equalTo(topRowStackView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(14)
            make.height.equalTo(1)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(14)
        }

        methodsStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(14)
            make.height.equalTo(94)
        }
    }

    func makeMethodView(for method: UpgradeMethod) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = Palette.methodBackground
        containerView.layer.cornerRadius = 12

        let iconBackgroundView = UIView()
        iconBackgroundView.backgroundColor = Palette.iconBackground
        iconBackgroundView.layer.cornerRadius = 24
        iconBackgroundView.layer.shadowColor = Palette.shadow.cgColor
        iconBackgroundView.layer.shadowOpacity = 1
        iconBackgroundView.layer.shadowRadius = 20
        iconBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 4)

        let iconImageView = UIImageView(image: method.icon)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = Palette.methodText

        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 11, weight: .regular)
        titleLabel.textColor = Palette.methodText
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.text = method.title

        containerView.addSubview(iconBackgroundView)
        iconBackgroundView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)

        iconBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(48)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconBackgroundView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(6)
            make.bottom.lessThanOrEqualToSuperview().inset(12)
        }

        return containerView
    }
}
