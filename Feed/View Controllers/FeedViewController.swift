//
//  FeedViewController.swift
//  Feed
//
//  Created by Ehud Adler on 2/6/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {

    // MARK: - Private iVars
    private var data: Feed
    private var feedView: FeedView

    // MARK: - Public inits
    init(data: Feed) {
        self.data = data
        self.feedView = FeedView(data: self.data)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNav()
    }

    // MARK: - Private methods
    private func setUpNav() {
        self.title = data.metadata.title
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setUpView() {
        self.view.addSubview(feedView)
        feedView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
}
