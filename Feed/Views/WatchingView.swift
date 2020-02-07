//
//  WatchingView.swift
//  Feed
//
//  Created by Ehud Adler on 2/6/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

final class WatchingView: UIView, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Weak iVars
    weak var delegate: WatchingViewDelegate?

    // MARK: - Private iVars
    private let tableView: UITableView = .init()
    private var data: [Feed] {
        didSet {
            performOnMain {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Public inits
    init(data: [Feed]) {
        self.data = data
        super.init(frame: .zero)
        registerCells()
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    public func update(dateSource newData: [Feed]) {
        data = newData
    }

    // MARK: - Private methods
    private func registerCells() {
         self.tableView.register(
             WatchTableViewCell.self,
             forCellReuseIdentifier: "WatchingCellID"
         )
     }

    private func setUpView() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()

        self.tableView.tableFooterView = UIView()
    }

    private func constructCell(feed: Feed, indexPath: IndexPath) -> WatchTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchingCellID", for: indexPath) as? WatchTableViewCell
                                                        else { return WatchTableViewCell() }
        cell.configure(model: feed)
        return cell
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return constructCell(feed: data[indexPath.row], indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCell(withFeed: data[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
