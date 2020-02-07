//
//  Presenter.swift
//  Feed
//
//  Created by Ehud Adler on 2/6/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit


enum PresentStyle {
    case model
    case push
}

class Presenter {

    static func present(
        viewController: UIViewController,
        onViewController: UIViewController,
        withStyle style: PresentStyle,
        withNavigationController: UINavigationController? = nil,
        animated: Bool,
        completionHandler: @escaping () -> Void = {}) {
        performOnMain {
            switch style {
            case .model:
                onViewController.present(viewController, animated: animated, completion: completionHandler)
            case .push:
                withNavigationController?.pushViewController(viewController, animated: animated)
            }
        }
    }

    static func dismiss(
        viewController: UIViewController,
        animated: Bool,
        completionHandler: @escaping () -> Void = {}) {
        performOnMain {
            viewController.dismiss(animated: animated, completion: completionHandler)
        }
    }
}
