//
//  Threading.swift
//  Feed
//
//  Created by Ehud Adler on 1/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import Foundation

enum Threads {
    case main
    case background
}

func perform(onThread: Threads, qos: DispatchQoS.QoSClass = .default, block: @escaping () -> Void) {
    switch onThread {
    case .main:
        performOnMain {
            block()
        }
    case .background:
        performOnBackground(qos: qos) {
            block()
        }
    }
}

func performOnMain(block:  @escaping () -> Void) {
    if Thread.isMainThread { block() }
    else {
      DispatchQueue.main.async(execute: block)
    }
}

func performOnBackground(qos: DispatchQoS.QoSClass = .default, block:  @escaping () -> Void) {
    DispatchQueue.global(qos: qos).async(execute: block)
}
