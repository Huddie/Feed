//
//  FeedableTextModelBuilder.swift
//  Feed
//
//  Created by Ehud Adler on 1/30/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//
import UIKit
import Eureka

protocol FeedableBuilderDelegate: class {
    func newItemCreated(model: FeedableModelWrapper)
}

class FeedableTextModelBuilder: FormViewController {

    weak var textBuilderDelegate: FeedableBuilderDelegate?
    
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
        form +++ Section("Main Content")
            <<< TextAreaRow(){ row in
                row.add(rule: RuleRequired())
                row.tag = "MainText"
                row.title = "Text"
                row.placeholder = "..."
            }.onChange({ row in
                guard let val = row.value else {
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                    return
                }
                self.navigationItem.rightBarButtonItem?.isEnabled = !val.isEmpty
            })
        form +++ Section("Font Options")
            <<< PushRow<String>() { row in
                row.tag = "FontAttributes"
                row.title = "Attributes"
                row.options = UIFont.fontNames(forFamilyName: "Avenir")
            }
            <<< IntRow() { row in
                row.tag = "FontSize"
                row.title = "Size"
                row.placeholder = "16"
            }
    }

    @objc public func reset() {
        for row in form.allRows {
            row.baseValue = nil
        }
    }

    @objc func tappedCreate() {
        guard let mainTextRow: TextAreaRow = form.rowBy(tag: "MainText"),
            let fontNameRow: PushRow<String> = form.rowBy(tag: "FontAttributes"),
            let fontSizeRow: IntRow = form.rowBy(tag: "FontSize") else { return }
        let fontSize: CGFloat = CGFloat(integerLiteral: fontSizeRow.value ?? 16)
        textBuilderDelegate?.newItemCreated(model: FeedableModelWrapper(type: .text, model: FeedableTextModel(
            text: mainTextRow.value!,
            fontName: fontNameRow.value,
            fontSize: fontSize
        )))
    }
}
