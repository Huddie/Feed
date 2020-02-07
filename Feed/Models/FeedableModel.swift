//
//  FeedableModel.swift
//  Feed
//
//  Created by Ehud Adler on 1/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

struct GenerateFeedableError: Error {}

protocol FeedableModel: Codable {
    static var id: Feedables { get }
    func encodeContent() throws -> String
}

extension FeedableModel {
    func encodeContent() throws -> String {
        let data = try! JSONEncoder().encode(self)
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
        return ""
    }
}

