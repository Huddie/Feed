//
//  FeedImageCache.swift
//  Feed
//
//  Created by Ehud Adler on 1/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

final class FeedImageCache: Cache<URL, UIImage> {
    static let shared: FeedImageCache = .init()
}
