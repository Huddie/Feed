//
//  AsyncImageProtocol.swift
//  Feed
//
//  Created by Ehud Adler on 1/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

protocol AsyncCacheProtocol {
    associatedtype CacheKey: Hashable
    associatedtype CacheValue
    var cache: Cache <CacheKey, CacheValue> { get set }
    func fetch(key: CacheKey, completionHandler: @escaping (Result<CacheValue, Error>) -> Void)
    init(cache inCache: Cache<CacheKey, CacheValue>)
}

