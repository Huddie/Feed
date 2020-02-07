//
//  Codable+Extensions.swift
//  Feed
//
//  Created by Ehud Adler on 2/2/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}

extension Encodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}
