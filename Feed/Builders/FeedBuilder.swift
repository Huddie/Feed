//
//  FeedBuilder.swift
//  Feed
//
//  Created by Ehud Adler on 2/6/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit
import Eureka

protocol FeedBuilderDelegate: class {
    func newFeedCreated(feed: Feed)
}

class FeedBuilder: FormViewController {

    weak var feedBuilderDelegate: FeedBuilderDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        addCreateButton()
        buildForm()
    }

    private func addCreateButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Create",
            style: .done,
            target: self,
            action: #selector(tappedCreate)
        )
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }

    private func buildForm() {
        form +++ Section("Metadata")
            <<< TextAreaRow(){ row in
                row.add(rule: RuleRequired())
                row.tag = "TitleTag"
                row.title = "Title"
                row.placeholder = "Article title"
            }.onChange({ row in
                guard let val = row.value else {
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                    return
                }
                self.navigationItem.rightBarButtonItem?.isEnabled = !val.isEmpty
            })
    }

    @objc public func reset() {
        for row in form.allRows {
            row.baseValue = nil
        }
    }

    @objc func tappedCreate() {
        guard let titleRow: TextAreaRow = form.rowBy(tag: "TitleTag") else { return }
        let title = titleRow.value ?? ""
        feedBuilderDelegate?.newFeedCreated(
            feed: Feed(metadata: FeedMetadata(title: title, createdOn: Date()),
            content: [])
        )
    }
}
