//
//  String+Regex.swift
//  Feed
//
//  Created by Ehud Adler on 1/4/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

extension NSTextCheckingResult {
    func resultForLocation(nsString: NSString, range: NSRange) -> String? {
        return range.location != NSNotFound
            ? nsString.substring(with: range)
            : nil
    }
}
