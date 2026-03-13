//
//  OffersDetailStepsCell.swift
//  test
//
//  Created by Cursor on 2026/3/12.
//

import UIKit
import SnapKit


final class OffersDetailStepRowCell: UITableViewCell {

    static let reuseIdentifier = "OffersDetailStepRowCell"

    private var textBottomConstraint: Constraint?

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor(red: 240 / 255, green: 242 / 255, blue: 245 / 255, alpha: 1).cgColor
        return label
    }()

    private lazy var stepTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        contentView.backgroundColor = .white
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(number: Int, text: String, isLast: Bool) {
        numberLabel.text = "\(number)"
        stepTextLabel.text = text
        textBottomConstraint?.update(inset: isLast ? 0 : 24)
    }
}

private extension OffersDetailStepRowCell {

    func setupUI() {
        addSubview(numberLabel)
        addSubview(stepTextLabel)

        numberLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(40)
        }

        stepTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(numberLabel.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            textBottomConstraint = make.bottom.equalToSuperview().inset(24).constraint
        }
    }
}
