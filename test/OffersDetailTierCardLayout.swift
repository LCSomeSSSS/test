//
//  OffersDetailTierCardLayout.swift
//  test
//
//  Created by Cursor on 2026/3/13.
//

import UIKit

enum OffersDetailTierCardLayout {
    static let preferredWidth: CGFloat = 191
    static let horizontalPadding: CGFloat = 14
    static let verticalPadding: CGFloat = 14
    static let sectionSpacing: CGFloat = 24
    static let rowSpacing: CGFloat = 4
    static let badgeHeight: CGFloat = 22
    static let footerHeight: CGFloat = 22
    static let iconWidth: CGFloat = 12
    static let iconTextSpacing: CGFloat = 6

    static func preferredHeight(
        for model: OffersDetailTierCardModel,
        width: CGFloat = preferredWidth
    ) -> CGFloat {
        let contentWidth = width - (horizontalPadding * 2)
        let textWidth = contentWidth - iconWidth - iconTextSpacing
        let textFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 16
        paragraphStyle.maximumLineHeight = 16

        let itemsHeight = model.items.reduce(CGFloat.zero) { partialResult, item in
            let textHeight = (item.text as NSString).boundingRect(
                with: CGSize(width: textWidth, height: .greatestFiniteMagnitude),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: [
                    .font: textFont,
                    .paragraphStyle: paragraphStyle
                ],
                context: nil
            ).height
            return partialResult + max(16, ceil(textHeight))
        }

        let totalRowSpacing = CGFloat(max(model.items.count - 1, 0)) * rowSpacing
        let totalFooterHeight = model.footer == nil ? 0 : sectionSpacing + footerHeight

        return verticalPadding
            + badgeHeight
            + sectionSpacing
            + itemsHeight
            + totalRowSpacing
            + totalFooterHeight
            + verticalPadding
    }
}
