//
//  WatchingViewDelegate.swift
//  Feed
//
//  Created by Ehud Adler on 2/6/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

protocol WatchingViewDelegate: class {
    func didSelectCell(withFeed: Feed)
}
