//
//  OffersDetailHeroCell.swift
//  test
//
//  Created by Cursor on 2026/3/12.
//

import UIKit
import SnapKit

final class OffersDetailHeroCell: UITableViewCell {

    static let reuseIdentifier = "OffersDetailHeroCell"
    var onBackTap: (() -> Void)?

    private lazy var heroContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 142 / 255, green: 106 / 255, blue: 70 / 255, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 150 / 255, green: 113 / 255, blue: 80 / 255, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var topOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 175 / 255, green: 134 / 255, blue: 93 / 255, alpha: 0.2)
        return view
    }()

    private lazy var bottomOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.16)
        return view
    }()

    private lazy var leftGlowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 239 / 255, green: 120 / 255, blue: 71 / 255, alpha: 0.9)
        view.layer.cornerRadius = 98
        return view
    }()

    private lazy var rightGlowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 127 / 255, green: 109 / 255, blue: 189 / 255, alpha: 0.7)
        view.layer.cornerRadius = 88
        return view
    }()

    private lazy var centerPedestalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 191 / 255, green: 151 / 255, blue: 95 / 255, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var centerCircleView: UIView = makeCenterCircleView(size: 74)
    private lazy var centerMiddleCircleView: UIView = makeCenterCircleView(size: 46)
    private lazy var centerInnerCircleView: UIView = makeCenterCircleView(size: 20)

    private lazy var topBarContainerView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var backButtonView: UIView = makeCapsuleView()
    private lazy var contactButtonView: UIView = makeCapsuleView()
    private lazy var shareButtonView: UIView = makeCapsuleView()

    private lazy var backLabel: UILabel = makeIconLabel(text: "‹")
    private lazy var contactLabel: UILabel = makeIconLabel(text: "☎")
    private lazy var shareLabel: UILabel = makeIconLabel(text: "↗")

    private lazy var actionButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contactButtonView, shareButtonView])
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()

    private lazy var carouselTagView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: effect)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var carouselIconLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.text = "▣"
        return label
    }()

    private lazy var carouselTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.text = "1 / 35"
        return label
    }()

    private lazy var carouselArrowLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.9)
        label.text = "›"
        return label
    }()

    private lazy var carouselStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [carouselIconLabel, carouselTextLabel, carouselArrowLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
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

    func configure(badgeText: String, title: String) {
        carouselTextLabel.text = "1 / 35"
    }
}

// MARK: - Private
private extension OffersDetailHeroCell {

    func setupUI() {
        contentView.addSubview(heroContainerView)
        heroContainerView.addSubview(backgroundImageView)
        heroContainerView.addSubview(topOverlayView)
        heroContainerView.addSubview(bottomOverlayView)
        heroContainerView.addSubview(leftGlowView)
        heroContainerView.addSubview(rightGlowView)
        heroContainerView.addSubview(topBarContainerView)
        heroContainerView.addSubview(centerPedestalView)
        heroContainerView.addSubview(centerCircleView)
        centerCircleView.addSubview(centerMiddleCircleView)
        centerMiddleCircleView.addSubview(centerInnerCircleView)
        heroContainerView.addSubview(carouselTagView)
        carouselTagView.contentView.addSubview(carouselStackView)
        backButtonView.addSubview(backLabel)
        contactButtonView.addSubview(contactLabel)
        shareButtonView.addSubview(shareLabel)
        topBarContainerView.addSubview(backButtonView)
        topBarContainerView.addSubview(actionButtonsStackView)

        heroContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(371)
        }

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        topOverlayView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }

        bottomOverlayView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(120)
        }

        leftGlowView.snp.makeConstraints { make in
            make.width.height.equalTo(180)
            make.leading.equalToSuperview().offset(-68)
            make.centerY.equalToSuperview().offset(40)
        }

        rightGlowView.snp.makeConstraints { make in
            make.width.height.equalTo(160)
            make.trailing.equalToSuperview().inset(-58)
            make.centerY.equalToSuperview().offset(14)
        }

        topBarContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(53)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }

        backButtonView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.equalTo(42)
            make.height.equalTo(30)
        }

        backLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        actionButtonsStackView.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
        }

        contactButtonView.snp.makeConstraints { make in
            make.width.equalTo(42)
            make.height.equalTo(32)
        }

        shareButtonView.snp.makeConstraints { make in
            make.width.equalTo(42)
            make.height.equalTo(32)
        }

        contactLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        shareLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        centerPedestalView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(66)
            make.width.equalTo(44)
            make.height.equalTo(104)
        }

        centerCircleView.snp.makeConstraints { make in
            make.centerX.equalTo(centerPedestalView)
            make.bottom.equalTo(centerPedestalView.snp.top).offset(12)
            make.width.height.equalTo(74)
        }

        centerMiddleCircleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(46)
        }

        centerInnerCircleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20)
        }

        carouselTagView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(26)
        }

        carouselStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6))
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackTap))
        backButtonView.addGestureRecognizer(tapGesture)
        backButtonView.isUserInteractionEnabled = true
    }

    func makeCapsuleView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        view.layer.cornerRadius = 10
        return view
    }

    func makeIconLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.text = text
        return label
    }

    func makeCenterCircleView(size: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 229 / 255, green: 205 / 255, blue: 165 / 255, alpha: 0.95)
        view.layer.cornerRadius = size / 2
        view.layer.borderWidth = size == 74 ? 3 : 0
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.45).cgColor
        return view
    }

    @objc
    func handleBackTap() {
        onBackTap?()
    }
}
