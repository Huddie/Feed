//
//  FeedableImageModel.swift
//  Feed
//
//  Created by Ehud Adler on 1/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

struct FeedableImageModel: FeedableModel {
    static var id: Feedables = .image
    let url: URL
    let width: CGFloat?
    let height: CGFloat?
}
