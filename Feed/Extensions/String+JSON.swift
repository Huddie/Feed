//
//  String+JSON.swift
//  Feed
//
//  Created by Ehud Adler on 1/29/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import Foundation


extension String {
    func jsonDecode<D>(to type: D.Type) -> D? where D: Decodable {
        let data: Data = self.data(using: .utf8)!
        do {
            return try D.decode(data: data)
        }
        catch {
            return nil
        }
    }
}
