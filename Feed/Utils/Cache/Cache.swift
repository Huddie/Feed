//
//  Cache.swift
//  Feed
//
//  Created by Ehud Adler on 1/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

class Cache<Key: Hashable, Value> {
    private let nsCache = NSCache<NSHashable<Key>, Entry>()


    public func set(object: Value, forKey key: Key) {
        nsCache.setObject(Entry(value: object), forKey: NSHashable(key))
    }

    public func object(forKey key: Key) -> Value? {
        let entry = nsCache.object(forKey: NSHashable(key))
        return entry?.value
    }

    public func removeObject(forKey key: Key) {
        nsCache.removeObject(forKey: NSHashable(key))
    }
}

private extension Cache {
    final class Entry {
        let value: Value

        init(value: Value) {
            self.value = value
        }
    }
}

extension Cache {
    subscript(key: Key) -> Value? {
        get { return object(forKey: key) }
        set {
            guard let value = newValue else {
                removeObject(forKey: key)
                return
            }
            set(object: value, forKey: key)
        }
    }
}
