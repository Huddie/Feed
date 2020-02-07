//
//  WatchTableViewCell.swift
//  Feed
//
//  Created by Ehud Adler on 2/6/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

final class WatchTableViewCell: UITableViewCell {

    // MARK: - Private iVars
    private let titleLabel: UILabel = .init()
    private let createdOnLabel: UILabel = .init()
    private let updatedOnLabel: UILabel = .init()

    // MARK: - Public inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func setUpView() {
        self.addSubview(titleLabel)
        self.addSubview(createdOnLabel)
        self.addSubview(updatedOnLabel)

        titleLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .semibold)
        createdOnLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: .light)
        updatedOnLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: .light)

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(20)
            make.top.equalTo(self).inset(10)
        }

        createdOnLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }

        updatedOnLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self).inset(20)
            make.bottom.equalTo(self).inset(5)
            make.top.equalTo(createdOnLabel.snp.bottom)
        }
    }

    // MARK: - Public methods
    public func configure(model: Feed) {

        titleLabel.text = model.metadata.title

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        createdOnLabel.text = formatter.string(from: model.metadata.createdOn)
    }
}
