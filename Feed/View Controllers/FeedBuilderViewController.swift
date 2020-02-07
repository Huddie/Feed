//
//  FeedBuilderViewController.swift
//  Feed
//
//  Created by Ehud Adler on 2/6/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

final class FeedBuilderViewController: UIViewController, FeedableBuilderDelegate{

    //MARK: - Private iVars
    private let cloudWorker: CloudWorker = CloudWorker.shared

    private let imageBuilder = FeedableImageModelBuilder()
    private let textBuilder = FeedableTextModelBuilder()

    private var data: Feed
    private var feedView: FeedView

    //MARK: - Public inits
    init(data: Feed) {
        self.data = data
        self.feedView = FeedView(data: self.data)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBuilders()
        setUpView()
        setUpNavButtons()
    }

     //MARK: - Private methods
    private func setUpBuilders() {
        imageBuilder.imageBuilderDelegate = self
        textBuilder.textBuilderDelegate = self
    }

    private func setUpNavButtons() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(
            title: "Submit Changes",
            style: .done,
            target: self,
            action: #selector(tappedSubmit)
            ),
              UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(tappedAdd)
            )
        ]
    }

    private func setUpView() {
        self.view.addSubview(feedView)
        feedView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }

    func newItemCreated(model: FeedableModelWrapper) {
        var content = data.content
        content.append(model)
        data = Feed(metadata: data.metadata, content: content)
        if imageBuilder.isViewLoaded {
            imageBuilder.dismiss(animated: true, completion: {self.imageBuilder.reset()})
        }

        if textBuilder.isViewLoaded {
            textBuilder.dismiss(animated: true, completion: {self.textBuilder.reset()})
        }

        feedView.update(dateSource: data)
    }

     //MARK: - @objc methods
    @objc private func tappedSubmit() {
        cloudWorker.newFeed(newFeed: data) { (result) in
            switch result {
            case let .success(uid):
                Presenter.dismiss(viewController: self, animated: true)
                print("UID: \(uid)")
            case let .failure(error):
                print("ERROR: \(error)")
            }
        }
    }

    @objc func tappedAdd() {
        let alertController = UIAlertController(title: "New Cell", message: nil, preferredStyle: .actionSheet)

        let textAction = UIAlertAction(title: "Text", style: .default, handler: { (action) in
            let navController = UINavigationController(rootViewController: self.textBuilder)
            self.present(navController, animated: true)
        })

        let imageAction = UIAlertAction(title: "Image", style: .default, handler: { (action) in
            let navController = UINavigationController(rootViewController: self.imageBuilder)
            self.present(navController, animated: true)
        })

        alertController.addAction(textAction)
        alertController.addAction(imageAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = self.view
            alertController.popoverPresentationController?.sourceRect = self.view.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.present(alertController, animated: true)
    }
}
