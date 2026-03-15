//
//  OffersDetailRelatedOfferCardView.swift
//  test
//
//  Created by Cursor on 2026/3/13.
//

import UIKit
import SnapKit

struct OffersDetailRelatedOfferItem {
    let title: String
    let subtitle: String
    let color: UIColor
}

final class OffersDetailRelatedOfferCardView: UIView {

    private let overlayGradientLayer = CAGradientLayer()

    private lazy var shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor(red: 31 / 255, green: 37 / 255, blue: 51 / 255, alpha: 0.05).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var imageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        overlayGradientLayer.frame = CGRect(
            x: 0,
            y: max(containerView.bounds.height - 90, 0),
            width: containerView.bounds.width,
            height: 90
        )
        shadowView.layer.shadowPath = UIBezierPath(
            roundedRect: shadowView.bounds,
            cornerRadius: shadowView.layer.cornerRadius
        ).cgPath
    }

    func configure(item: OffersDetailRelatedOfferItem) {
        imageView.backgroundColor = item.color
        titleLabel.text = item.title
        accessibilityLabel = [item.title, item.subtitle].joined(separator: ", ")
    }
}

// MARK: - Private
private extension OffersDetailRelatedOfferCardView {

    func setupGradient() {
        overlayGradientLayer.colors = [
            UIColor.black.withAlphaComponent(0).cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor
        ]
        overlayGradientLayer.locations = [0, 0.55]
        overlayGradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        overlayGradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        containerView.layer.addSublayer(overlayGradientLayer)
    }

    func setupUI() {
        backgroundColor = .clear
        setupGradient()

        addSubview(shadowView)
        shadowView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)

        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}
