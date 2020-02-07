//
//  FeedCellProtocol.swift
//  Feed
//
//  Created by Ehud Adler on 1/4/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit


protocol FeedableCell: UITableViewCell {
    associatedtype Model: FeedableModel
    static var id: Feedables { get }
    var model: Model? { get set }
    func configure(model: FeedableModel)
}

extension FeedableCell {
    static var id: Feedables {
        return Model.id
    }
}





