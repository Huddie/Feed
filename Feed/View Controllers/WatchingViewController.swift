//
//  WatchingTableViewController.swift
//  Feed
//
//  Created by Ehud Adler on 2/6/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

final class WatchingViewController: UIViewController, FeedBuilderDelegate, WatchingViewDelegate {

    // MARK: - Private iVars
    private let feedBuilder = FeedBuilder()
    private let cloudWorker: CloudWorker = CloudWorker.shared
    private var watchingView: WatchingView
    private var data: [Feed] {
        didSet {
            watchingView.update(dateSource: data)
        }
    }

    // MARK: - Public inits
    init(data: [Feed] = [Feed]()) {
        self.data = data
        self.watchingView = WatchingView(data: self.data)
        super.init(nibName: nil, bundle: nil)
        setUpView()
        setUpDelegates()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpNavbar()
    }

    // MARK: -- Private methods
    private func setUpView() {
        self.view.addSubview(watchingView)
        watchingView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }

    private func setUpDelegates() {
        watchingView.delegate = self
        feedBuilder.feedBuilderDelegate = self
    }

    private func setUpNavbar() {
        self.title = "Watching"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(tappedNew)
        )
    }

    private func refresh() {
        cloudWorker.queryFeed(uid: "24C97625-FFEC-44C0-82CA-76CE99EFAAF2") { [unowned self] (result) in
            switch result {
            case let .success(newData):
                self.update(dateSource: newData)
            case let .failure(error):
                print("ERROR: \(error)")
            }
        }
    }

    private func update(dateSource newData: [Feed]) {
        data = newData
    }

    // MARK: - @objc methods
    @objc private func tappedNew() {
        Presenter.present(
            viewController: UINavigationController(rootViewController: feedBuilder),
            onViewController: self,
            withStyle: .model, animated: true)
    }


    // MARK: - FeedBuilderDelegate
    internal func newFeedCreated(feed: Feed) {
         if feedBuilder.isViewLoaded {
             Presenter.dismiss(viewController: feedBuilder, animated: true) {
                 self.feedBuilder.reset()
                 Presenter.present(
                     viewController: UINavigationController(rootViewController: FeedBuilderViewController(data: feed)),
                     onViewController: self,
                     withStyle: .model, animated: true)
             }
         } else {
             Presenter.present(
                 viewController: UINavigationController(rootViewController: FeedBuilderViewController(data: feed)),
                 onViewController: self,
                 withStyle: .model, animated: true)
         }
     }


    // MARK: - WatchingViewDelegate
    func didSelectCell(withFeed: Feed) {
        self.navigationController?.pushViewController(
             FeedViewController(data: withFeed),
             animated: true
         )
    }
}


