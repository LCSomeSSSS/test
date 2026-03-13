//
//  OffersDetailTierCardView.swift
//  test
//
//  Created by Cursor on 2026/3/13.
//

import UIKit
import SnapKit

final class OffersDetailTierCardView: UIView {

    private lazy var shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [badgeWrapperView, benefitsStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = OffersDetailTierCardLayout.sectionSpacing
        return stackView
    }()

    private lazy var badgeWrapperView: UIView = UIView()
    private lazy var badgeButton = ChipButton()

    private lazy var benefitsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = OffersDetailTierCardLayout.rowSpacing
        return stackView
    }()

    private lazy var footerContainerView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()

    private lazy var footerButton = ChipButton()

    private var rowViews: [OffersDetailBenefitRowView] = []
    private var footerTopConstraint: Constraint?
    private var footerHeightConstraint: Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func apply(model: OffersDetailTierCardModel) {
        containerView.backgroundColor = model.style.cardBackgroundColor
        containerView.layer.borderColor = model.style.cardBorderColor.cgColor
        shadowView.layer.shadowColor = model.style.shadowColor.cgColor

        let badgePrefix: String?
        switch model.header.kind {
        case .textBadge:
            badgePrefix = nil
        case .iconBadge(let iconText):
            badgePrefix = iconText
        }

        badgeButton.apply(
            content: .init(title: model.header.title, prefix: badgePrefix),
            style: .small(
                textColor: model.style.badgeTextColor,
                backgroundColor: model.style.badgeBackgroundColor
            )
        )

        syncRowViews(with: model.items.count)
        rowViews.enumerated().forEach { index, rowView in
            rowView.isHidden = index >= model.items.count
            guard index < model.items.count else { return }
            rowView.apply(
                item: model.items[index],
                primaryTextColor: model.style.primaryTextColor,
                secondaryTextColor: model.style.secondaryTextColor
            )
        }

        if let footer = model.footer {
            footerContainerView.isHidden = false
            footerButton.apply(
                content: .init(title: footer.text),
                style: .small(
                    textColor: footer.textColor,
                    backgroundColor: footer.backgroundColor
                )
            )
            footerTopConstraint?.update(offset: OffersDetailTierCardLayout.sectionSpacing)
            footerHeightConstraint?.update(offset: OffersDetailTierCardLayout.footerHeight)
        } else {
            footerContainerView.isHidden = true
            footerButton.reset()
            footerTopConstraint?.update(offset: 0)
            footerHeightConstraint?.update(offset: 0)
        }
    }

    func reset() {
        badgeButton.reset()
        footerContainerView.isHidden = true
        footerButton.reset()
        footerTopConstraint?.update(offset: 0)
        footerHeightConstraint?.update(offset: 0)
    }
}

private extension OffersDetailTierCardView {

    func syncRowViews(with count: Int) {
        while rowViews.count < count {
            let rowView = OffersDetailBenefitRowView()
            rowViews.append(rowView)
            benefitsStackView.addArrangedSubview(rowView)
        }
    }

    func setupUI() {
        backgroundColor = .clear
        addSubview(shadowView)
        shadowView.addSubview(containerView)
        containerView.addSubview(contentStackView)
        containerView.addSubview(footerContainerView)
        badgeWrapperView.addSubview(badgeButton)
        footerContainerView.addSubview(footerButton)

        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(OffersDetailTierCardLayout.verticalPadding)
            make.leading.trailing.equalToSuperview().inset(OffersDetailTierCardLayout.horizontalPadding)
        }

        badgeWrapperView.snp.makeConstraints { make in
            make.height.equalTo(OffersDetailTierCardLayout.badgeHeight)
        }

        badgeButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }

        footerContainerView.snp.makeConstraints { make in
            footerTopConstraint = make.top.equalTo(contentStackView.snp.bottom).offset(OffersDetailTierCardLayout.sectionSpacing).constraint
            make.leading.equalToSuperview().offset(OffersDetailTierCardLayout.horizontalPadding)
            make.trailing.lessThanOrEqualToSuperview().inset(OffersDetailTierCardLayout.horizontalPadding)
            footerHeightConstraint = make.height.equalTo(OffersDetailTierCardLayout.footerHeight).constraint
            make.bottom.lessThanOrEqualToSuperview().inset(OffersDetailTierCardLayout.verticalPadding)
        }

        footerButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
    }
}

private final class OffersDetailBenefitRowView: UIView {

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 10, weight: .semibold)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func apply(item: OffersDetailBenefitItem, primaryTextColor: UIColor, secondaryTextColor: UIColor) {
        let textColor: UIColor
        let symbolName: String

        switch item.state {
        case .available:
            textColor = primaryTextColor
            symbolName = "checkmark"
        case .locked:
            textColor = secondaryTextColor
            symbolName = "lock"
        }

        iconImageView.image = UIImage(systemName: symbolName)
        iconImageView.tintColor = textColor
        textLabel.attributedText = NSAttributedString(
            string: item.text,
            attributes: [
                .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                .foregroundColor: textColor,
                .paragraphStyle: Self.textParagraphStyle
            ]
        )
    }
}

private extension OffersDetailBenefitRowView {

    static let textParagraphStyle: NSParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = 16
        style.maximumLineHeight = 16
        return style
    }()

    func setupUI() {
        addSubview(iconImageView)
        addSubview(textLabel)

        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(2)
            make.width.height.equalTo(12)
        }

        textLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(6)
        }
    }
}
