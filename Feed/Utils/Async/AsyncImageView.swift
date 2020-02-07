//
//  AsyncImageView.swift
//  Feed
//
//  Created by Ehud Adler on 1/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

class AsyncImageView: UIImageView, AsyncCacheProtocol {

    typealias CacheKey = URL
    typealias CacheValue = UIImage
    typealias Handler = (Result<CacheValue, Error>) -> Void

    var cache: Cache<URL, UIImage>

    let fetcher: AsyncFetcher = .init()
    let placeholder: UIImage

    internal func fetch(key: URL, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = self.cache.object(forKey: key) {
            completionHandler(.success(image))
        }
        fetcher.fetch(request: URLRequest(url: key)) { (result) in
            switch result {
            case let .success(data):
                if let image = UIImage(data: data) {
                    self.cache.set(object: image, forKey: key)
                    completionHandler(.success(image))
                }
            case let .failure(error):
                print(error)
                completionHandler(.failure(error))
            }
        }
    }

    internal func set(value: UIImage, forKey: URL) {
        cache.set(object: value, forKey: forKey)
    }

    func setImage(forKey: URL) {
        fetch(key: forKey) { (result) in
            switch result {
                case let .success(image):
                    performOnMain {
                         self.image = image
                    }
                case let .failure(error):
                    performOnMain {
                         self.image = self.placeholder
                    }
                    print(error)
            }
        }
    }

    required init(cache inCache: Cache<URL, UIImage>) {
        self.cache = inCache
        self.placeholder = UIImage()
        super.init(frame: .zero)
    }
    
    required init(cache inCache: Cache<CacheKey, CacheValue>, placeholder: UIImage = .init()) {
        self.cache = inCache
        self.placeholder = placeholder
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
