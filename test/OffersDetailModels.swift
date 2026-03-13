//
//  OffersDetailModels.swift
//  test
//
//  Created by Cursor on 2026/3/12.
//

import UIKit

struct OffersDetailBenefitItem {
    enum State {
        case available
        case locked
    }

    let text: String
    let state: State
}

struct OffersDetailTierCardModel {
    struct Header {
        enum Kind {
            case textBadge
            case iconBadge(iconText: String)
        }

        let title: String
        let kind: Kind
    }

    struct Footer {
        let text: String
        let backgroundColor: UIColor
        let textColor: UIColor
    }

    struct Style {
        let cardBackgroundColor: UIColor
        let cardBorderColor: UIColor
        let badgeBackgroundColor: UIColor
        let badgeTextColor: UIColor
        let primaryTextColor: UIColor
        let secondaryTextColor: UIColor
        let shadowColor: UIColor
    }

    let header: Header
    let style: Style
    let footer: Footer?
    let items: [OffersDetailBenefitItem]
}
