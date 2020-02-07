//
//  FeedTableView.swift
//  Feed
//
//  Created by Ehud Adler on 2/6/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

final class FeedView: UIView, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Private iVars
    private let tableView: UITableView = .init()
    private var data: Feed {
        didSet {
            self.tableView.reloadData()
        }
    }

    // MARK: - Public inits
    init(data: Feed) {
        self.data = data
        super.init(frame: .zero)
        registerCells()
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    public func update(dateSource newData: Feed) {
        data = newData
    }

    // MARK: - Private methods
    private func registerCells() {
        self.tableView.register(
            FeedTextCell.self,
            forCellReuseIdentifier: "\(FeedTextCell.id)"
        )
        self.tableView.register(
            FeedImageCell.self,
            forCellReuseIdentifier: "\(FeedImageCell.id)"
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

    private func constructCell(wrapper: FeedableModelWrapper) -> UITableViewCell {
        switch wrapper.type {
        case .image:
            guard let imageModel = wrapper.feedableModel as? FeedableImageModel else { return  UITableViewCell() }
            return FeedImageCell(style: .default, reuseIdentifier: "\(FeedImageCell.id)", model: imageModel)
        case .text:
            guard let textModel = wrapper.feedableModel as? FeedableTextModel else { return  UITableViewCell() }
            return FeedTextCell(style: .default, reuseIdentifier: "\(FeedTextCell.id)", model: textModel)
        case .blank:
            return UITableViewCell()
        }
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
        return data.content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return constructCell(wrapper: data.content[indexPath.row])
    }
}
