//
//  ViewController.swift
//  test
//
//  Created by GangTaiiOS on 2025/9/22.
//  Copyright © 2025 galaxy. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - ViewController
class ViewController: UIViewController {

    private lazy var items: [String] = {
        ["Open Offers Detail Demo"]
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .systemGroupedBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.cellReuseIdentifier)
        return tableView
    }()

    private static let cellReuseIdentifier = "HomeDemoCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Offers"
        view.backgroundColor = .systemBackground
        setupUI()
    }
}

// MARK: - Private
private extension ViewController {

    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellReuseIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = items[indexPath.row]
        content.secondaryText = "Tap to open the offers detail page"
        content.secondaryTextProperties.color = .secondaryLabel
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(OffersDetailViewController1(), animated: true)
    }
}