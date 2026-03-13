//
//  ChipButton.swift
//  test
//
//  Created by Cursor on 2026/3/13.
//

import UIKit

final class ChipButton: UIButton {

    struct Style {
        let textColor: UIColor
        let backgroundColor: UIColor
        let font: UIFont
        let contentInsets: NSDirectionalEdgeInsets
        let cornerRadius: CGFloat

        static func small(textColor: UIColor, backgroundColor: UIColor) -> Style {
            Style(
                textColor: textColor,
                backgroundColor: backgroundColor,
                font: .systemFont(ofSize: 11, weight: .regular),
                contentInsets: NSDirectionalEdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6),
                cornerRadius: 6
            )
        }
    }

    struct Content {
        let title: String
        let prefix: String?

        init(title: String, prefix: String? = nil) {
            self.title = title
            self.prefix = prefix
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        titleLabel?.lineBreakMode = .byTruncatingTail
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func apply(content: Content, style: Style) {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = style.contentInsets
        configuration.background.backgroundColor = style.backgroundColor
        configuration.background.cornerRadius = style.cornerRadius
        configuration.baseForegroundColor = style.textColor

        let displayTitle = content.prefix.map { "\($0) \(content.title)" } ?? content.title
        var attributedTitle = AttributedString(displayTitle)
        attributedTitle.font = style.font
        attributedTitle.foregroundColor = style.textColor
        configuration.attributedTitle = attributedTitle

        self.configuration = configuration
    }

    func reset() {
        configuration = nil
        setTitle(nil, for: .normal)
    }
}
