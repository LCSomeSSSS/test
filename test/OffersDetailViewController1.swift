//
//  OffersDetailViewController1.swift
//  test
//
//  Created by Cursor on 2026/3/12.
//

import UIKit
import SnapKit

// MARK: - OffersDetailViewController1
final class OffersDetailViewController1: UIViewController {

    private struct SummarySectionItem {
        let title: String
        let subtitle: String
        var seeMoreState: OffersDetailSummaryCell.SeeMoreState
    }

    private var summaryItem = SummarySectionItem(
        title: "Gold, Glory & Galaxy Lucky Draw",
        subtitle: "Members who have a stay at eligible Galaxy Macau hotels can secure a chance to join this reward campaign.Members who have a stay at eligible Galaxy Macau hotels can secure a chance to join this reward campaign.",
        seeMoreState: .plain
    )
    private var lastSummaryMeasureWidth: CGFloat = 0

    private enum RowItem {
        case summary
        case summaryInfo
        case actions
        case qualifiedOffer
        case upgradePrompt
        case details
        case howToUseStep(Int)
        case related
    }

    private lazy var rows: [RowItem] = {
        var items: [RowItem] = [ .summary, .summaryInfo, .actions, .qualifiedOffer, .upgradePrompt, .details]
        items.append(contentsOf: usageSteps.indices.map { .howToUseStep($0) })
        items.append(contentsOf: [.related])
        return items
    }()

    private lazy var detailCards: [OffersDetailTierCardModel] = {
        [
            OffersDetailTierCardModel(
                header: .init(
                    title: "GPC Gold",
                    kind: .textBadge
                ),
                style: .init(
                    cardBackgroundColor: UIColor(red: 250 / 255, green: 245 / 255, blue: 235 / 255, alpha: 1),
                    cardBorderColor: UIColor(red: 247 / 255, green: 227 / 255, blue: 186 / 255, alpha: 1),
                    badgeBackgroundColor: UIColor(red: 108 / 255, green: 90 / 255, blue: 55 / 255, alpha: 1),
                    badgeTextColor: .white,
                    primaryTextColor: UIColor(red: 89 / 255, green: 72 / 255, blue: 38 / 255, alpha: 1),
                    secondaryTextColor: UIColor(red: 89 / 255, green: 72 / 255, blue: 38 / 255, alpha: 0.5),
                    shadowColor: UIColor(red: 31 / 255, green: 37 / 255, blue: 51 / 255, alpha: 0.05)
                ),
                footer: .init(
                    text: "Your Current Tier",
                    backgroundColor: .white,
                    textColor: .black
                ),
                items: [
                    OffersDetailBenefitItem(text: "1 Night Stay", state: .available),
                    OffersDetailBenefitItem(text: "Free access to Grand Resort Deck (Valued at MOP888)", state: .available),
                    OffersDetailBenefitItem(text: "Daily Breakfast for 2 at Andaz Kitchen", state: .locked),
                    OffersDetailBenefitItem(text: "Use of Andaz Lounge", state: .locked),
                    OffersDetailBenefitItem(text: "Complimentary Mini Bar (Once per Stay)", state: .locked)
                ]
            ),
            OffersDetailTierCardModel(
                header: .init(
                    title: "Galaxy Life Diamond",
                    kind: .iconBadge(iconText: "P")
                ),
                style: .init(
                    cardBackgroundColor: UIColor(red: 240 / 255, green: 242 / 255, blue: 245 / 255, alpha: 1),
                    cardBorderColor: UIColor(red: 223 / 255, green: 225 / 255, blue: 230 / 255, alpha: 1),
                    badgeBackgroundColor: .black,
                    badgeTextColor: .white,
                    primaryTextColor: UIColor(red: 46 / 255, green: 48 / 255, blue: 51 / 255, alpha: 1),
                    secondaryTextColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5),
                    shadowColor: UIColor(red: 31 / 255, green: 37 / 255, blue: 51 / 255, alpha: 0.05)
                ),
                footer: nil,
                items: [
                    OffersDetailBenefitItem(text: "1 Night Stay", state: .available),
                    OffersDetailBenefitItem(text: "Free access to Grand Resort Deck (Valued at MOP888)", state: .available),
                    OffersDetailBenefitItem(text: "Daily Breakfast for 2 at Andaz Kitchen", state: .available),
                    OffersDetailBenefitItem(text: "Use of Andaz Lounge", state: .available),
                    OffersDetailBenefitItem(text: "Complimentary Mini Bar (Once per Stay)", state: .locked)
                ]
            ),
            OffersDetailTierCardModel(
                header: .init(
                    title: "GPC Gold",
                    kind: .textBadge
                ),
                style: .init(
                    cardBackgroundColor: UIColor(red: 243 / 255, green: 240 / 255, blue: 250 / 255, alpha: 1),
                    cardBorderColor: UIColor(red: 230 / 255, green: 224 / 255, blue: 245 / 255, alpha: 1),
                    badgeBackgroundColor: UIColor(red: 70 / 255, green: 55 / 255, blue: 98 / 255, alpha: 1),
                    badgeTextColor: .white,
                    primaryTextColor: UIColor(red: 70 / 255, green: 57 / 255, blue: 96 / 255, alpha: 1),
                    secondaryTextColor: UIColor(red: 70 / 255, green: 57 / 255, blue: 96 / 255, alpha: 0.6),
                    shadowColor: UIColor(red: 31 / 255, green: 37 / 255, blue: 51 / 255, alpha: 0.05)
                ),
                footer: nil,
                items: [
                    OffersDetailBenefitItem(text: "1 Night Stay", state: .available),
                    OffersDetailBenefitItem(text: "Free access to Grand Resort Deck (Valued at MOP888)", state: .available),
                    OffersDetailBenefitItem(text: "Daily Breakfast for 2 at Andaz Kitchen", state: .available),
                    OffersDetailBenefitItem(text: "Use of Andaz Lounge", state: .available),
                    OffersDetailBenefitItem(text: "Complimentary Mini Bar (Once per Stay)", state: .available)
                ]
            )
        ]
    }()

    private lazy var usageSteps: [String] = {
        [
            "Pay with your UnionPay card at any Galaxy Macau merchant (e.g., restaurants, shops). Keep your same-day transaction receipt.",
            "Head to the East Promenade Concierge (located right next to McDonald’s).",
            "Present your same-day UnionPay receipt + valid passport to register as a Galaxy Ultimate Member (required for redemption).",
            "Choose one complimentary item: Portuguese tile-style coaster or Fresh Portuguese egg tart."
        ]
    }()

    private lazy var bookingItems: [(String, String)] = {
        [
            ("Booking Period", "From now until September 30, 2026"),
            ("Stay Period", "From now until October 31, 2026")
        ]
    }()

    private lazy var upgradePromptMethods: [OffersDetailUpgradePromptCell.UpgradeMethod] = {
        [
            .init(icon: UIImage(systemName: "building.2"), title: "Book Hotel"),
            .init(icon: UIImage(systemName: "fork.knife"), title: "Book Dining"),
            .init(icon: UIImage(systemName: "mic"), title: "Book Concert")
        ]
    }()

    private lazy var relatedOffers: [OffersDetailRelatedOfferItem] = {
        [
            .init(title: "Summer Staycation", subtitle: "Exclusive", color: UIColor(red: 171 / 255, green: 120 / 255, blue: 44 / 255, alpha: 1)),
            .init(title: "Deluxe Tea View", subtitle: "Andaz Macau", color: UIColor(red: 206 / 255, green: 150 / 255, blue: 98 / 255, alpha: 1)),
            .init(title: "Galaxy Lucky Draw", subtitle: "Macau", color: UIColor(red: 98 / 255, green: 92 / 255, blue: 116 / 255, alpha: 1)),
            .init(title: "Galaxy Lucky Draw", subtitle: "Macau", color: UIColor(red: 98 / 255, green: 92 / 255, blue: 116 / 255, alpha: 1))
        ]
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OffersDetailSummaryCell.self, forCellReuseIdentifier: OffersDetailSummaryCell.reuseIdentifier)
        tableView.register(OffersDetailSummaryInfoCell.self, forCellReuseIdentifier: OffersDetailSummaryInfoCell.reuseIdentifier)
        tableView.register(OffersDetailActionCell.self, forCellReuseIdentifier: OffersDetailActionCell.reuseIdentifier)
        tableView.register(
            OffersDetailQualifiedOfferCell.self,
            forCellReuseIdentifier: OffersDetailQualifiedOfferCell.reuseIdentifier
        )
        tableView.register(
            OffersDetailUpgradePromptCell.self,
            forCellReuseIdentifier: OffersDetailUpgradePromptCell.reuseIdentifier
        )
        tableView.register(OffersDetailDetailGridCell.self, forCellReuseIdentifier: OffersDetailDetailGridCell.reuseIdentifier)
        tableView.register(OffersDetailStepRowCell.self, forCellReuseIdentifier: OffersDetailStepRowCell.reuseIdentifier)
        tableView.register(OffersDetailRelatedOffersCell.self, forCellReuseIdentifier: OffersDetailRelatedOffersCell.reuseIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = " "
        view.backgroundColor = .white
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateSummarySeeMoreStateIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK: - Private
private extension OffersDetailViewController1 {

    var summarySubtitleFont: UIFont {
        .systemFont(ofSize: 14, weight: .regular)
    }

    func shouldShowSummarySeeMore() -> Bool {
        let availableWidth = max((tableView.bounds.width > 0 ? tableView.bounds.width : view.bounds.width) - 32, 0)
        guard availableWidth > 0 else { return false }

        let textHeight = (summaryItem.subtitle as NSString).boundingRect(
            with: CGSize(width: availableWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: summarySubtitleFont],
            context: nil
        ).height

        let collapsedHeight = summarySubtitleFont.lineHeight * 3
        return ceil(textHeight) > ceil(collapsedHeight)
    }

    func updateSummarySeeMoreStateIfNeeded() {
        let availableWidth = max((tableView.bounds.width > 0 ? tableView.bounds.width : view.bounds.width) - 32, 0)
        guard availableWidth > 0, abs(availableWidth - lastSummaryMeasureWidth) > 0.5 else { return }

        lastSummaryMeasureWidth = availableWidth
        let shouldShowSeeMore = shouldShowSummarySeeMore()
        let previousState = summaryItem.seeMoreState

        if shouldShowSeeMore {
            if summaryItem.seeMoreState == .plain {
                summaryItem.seeMoreState = .collapsed
            }
        } else {
            summaryItem.seeMoreState = .plain
        }

        guard previousState != summaryItem.seeMoreState else { return }
        guard let summaryRow = rows.firstIndex(where: {
            if case .summary = $0 { return true }
            return false
        }) else { return }
        let indexPath = IndexPath(row: summaryRow, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
    }

    func toggleSummarySeeMore() {
        switch summaryItem.seeMoreState {
        case .plain:
            return
        case .collapsed:
            summaryItem.seeMoreState = .expanded
        case .expanded:
            summaryItem.seeMoreState = .collapsed
        }
    }

    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func rowItem(at indexPath: IndexPath) -> RowItem {
        rows[indexPath.row]
    }
}

// MARK: - UITableViewDataSource
extension OffersDetailViewController1: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rowItem(at: indexPath) {
        case .summary:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OffersDetailSummaryCell.reuseIdentifier,
                for: indexPath
            ) as! OffersDetailSummaryCell
            cell.configure(
                title: summaryItem.title,
                subtitle: summaryItem.subtitle,
                state: summaryItem.seeMoreState
            )
            cell.onSeeMoreTap = { [weak self, weak tableView] cell in
                guard let self, let tableView else { return }
                self.toggleSummarySeeMore()
                cell.configure(
                    title: self.summaryItem.title,
                    subtitle: self.summaryItem.subtitle,
                    state: self.summaryItem.seeMoreState
                )

                UIView.performWithoutAnimation {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            }
            return cell

        case .summaryInfo:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OffersDetailSummaryInfoCell.reuseIdentifier,
                for: indexPath
            ) as! OffersDetailSummaryInfoCell
            cell.configure(
                dateText: "From now until October 31, 2025",
                venue: "Andaz Macau",
                merchantText: "Andaz Hotel Macau"
            )
            return cell

        case .actions:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OffersDetailActionCell.reuseIdentifier,
                for: indexPath
            ) as! OffersDetailActionCell
            cell.configure(
                hintText: "Specific members who have joined this promotional activity can unlock the privilege entry button.",
                primaryTitle: "Join Lucky Privilege"
            )
            return cell

        case .qualifiedOffer:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OffersDetailQualifiedOfferCell.reuseIdentifier,
                for: indexPath
            ) as! OffersDetailQualifiedOfferCell
            cell.configure(
                title: "You’ve Qualified to Enjoy This Exclusive Offer.",
                subtitle: "Galaxy Privilege Diamond Members can enjoy exclusive access to this offer."
            )
            return cell

        case .upgradePrompt:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OffersDetailUpgradePromptCell.reuseIdentifier,
                for: indexPath
            ) as! OffersDetailUpgradePromptCell
            cell.configure(
                title: "Upgrade Now To Join Offer!",
                subtitle: "Galaxy Privilege Diamond Members and above can enjoy access to this exclusive offer.",
                description: "The more you spend, the more you earn! Every spend at Galaxy Macau helps you level up your membership.",
                methods: upgradePromptMethods
            )
            return cell

        case .details:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OffersDetailDetailGridCell.reuseIdentifier,
                for: indexPath
            ) as! OffersDetailDetailGridCell
            cell.configure(cards: detailCards)
            return cell

        case .howToUseStep(let index):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OffersDetailStepRowCell.reuseIdentifier,
                for: indexPath
            ) as! OffersDetailStepRowCell
            cell.configure(
                number: index + 1,
                text: usageSteps[index],
                isLast: index == usageSteps.count - 1
            )
            return cell

        case .related:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: OffersDetailRelatedOffersCell.reuseIdentifier,
                for: indexPath
            ) as! OffersDetailRelatedOffersCell
            cell.configure(title: "Related Offers", items: relatedOffers)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension OffersDetailViewController1: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
