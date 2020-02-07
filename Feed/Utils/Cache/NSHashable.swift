//
//  NSHashable.swift
//  Feed
//
//  Created by Ehud Adler on 1/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

final class NSHashable<Key: Hashable>: NSObject {
    let key: Key

    init(_ key: Key) { self.key = key }

    override var hash: Int { return key.hashValue }

    override func isEqual(_ object: Any?) -> Bool {
        guard let value = object as? NSHashable else {
            return false
        }
        return value.key == key
    }
}
