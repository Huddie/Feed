//
//  FeedableTextModel.swift
//  Feed
//
//  Created by Ehud Adler on 1/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

struct FeedableTextModel: FeedableModel {
    static var id: Feedables = .text
    let text: String
    let fontName: String?
    let fontSize: CGFloat?
}
