//
//  FeedTextCell.swift
//  Feed
//
//  Created by Ehud Adler on 1/4/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

final class FeedTextCell: UITableViewCell, FeedableCell {

    //MARK: - FeedableCell
    typealias Model = FeedableTextModel
    var model: FeedableTextModel?

    //MARK: - FeedableCell Methods
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, model: FeedableModel) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure(model: model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    //MARK: - FeedableCell methods
    func configure(model: FeedableModel)  {
        guard let model = model as? FeedableTextModel else { return }
        self.model = model
        textLabel?.text = model.text
        textLabel?.numberOfLines = -1
        textLabel?.font = UIFont(name: model.fontName ?? "", size: model.fontSize ?? 16)
    }
}
