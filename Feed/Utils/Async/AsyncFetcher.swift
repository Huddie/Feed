//
//  AsyncFetcher.swift
//  Feed
//
//  Created by Ehud Adler on 1/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

class AsyncFetcher {
    typealias Handler = (Result<Data, Error>) -> Void
    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch(
        request:  URLRequest,
        qos: DispatchQoS.QoSClass = .default,
        completionHandler: @escaping Handler) {

        let task = session.dataTask(with: request) { data, response, error in
          if let error = error {
            completionHandler(.failure(error))
          } else if let data = data {
            completionHandler(.success(data))
          }
        }
        task.resume()
    }
}
