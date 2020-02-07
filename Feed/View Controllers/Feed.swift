//
//  Feed.swift
//  Feed
//
//  Created by Ehud Adler on 2/6/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

struct FeedMetadata: Codable {
    let title: String
    let createdOn: Date
}

struct Feed: Codable {
    let metadata: FeedMetadata
    let content: [FeedableModelWrapper]
}
