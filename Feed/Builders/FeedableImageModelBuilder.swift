//
//  FeedableImageModelBuilder.swift
//  Feed
//
//  Created by Ehud Adler on 1/30/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//


import UIKit
import Eureka
import SnapKit

class FeedableImageModelBuilder: FormViewController, ImagePickerDelegate {

    weak var imageBuilderDelegate: FeedableBuilderDelegate?
    var imagePicker: ImagePicker!
    var imageSection = Section("Image Picker")
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        addCreateButton()
        buildForm()
        setUpImagePicker()
    }


    private func setUpImagePicker() {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
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

        var header = HeaderFooterView<UIView>(.class)
        header.height = { 100 }
        header.onSetupView = { view, section in
            let imageView = UIImageView(image: self.image)
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            view.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.edges.equalTo(view)
            }
        }

        imageSection.header = header

        form +++ imageSection
            <<< ButtonRow(){ row in
                row.title = "Choose Image"
                row.add(rule: RuleRequired())
                row.tag = "ImageTag"
            }.onCellSelection({ (cellOf, buttonRow) in
                self.imagePicker.present(from: self.view)
            })
        form +++ Section("Cusomization")
            <<< IntRow() { row in
                row.tag = "HeightTag"
                row.title = "Height"
                row.placeholder = "100"
            }.onChange({ (row) in
                self.imageSection.header?.height = { CGFloat(integerLiteral: row.value ?? 0) }
                self.imageSection.reload()
            })
    }

    @objc public func reset() {
        image = nil
        self.imageSection.header?.height = { 100 }
        for row in form.allRows {
            row.baseValue = nil
        }
        self.imageSection.reload()
    }

    @objc func tappedCreate() {
        let heightRow: IntRow? = form.rowBy(tag: "HeightTag")
        imageBuilderDelegate?.newItemCreated(model: FeedableModelWrapper(type: .image, model: FeedableImageModel(
            url: URL(string: "https://i.ytimg.com/vi/JnS2d2a9yis/maxresdefault.jpg")!,
            width: nil,
            height: CGFloat(integerLiteral: heightRow?.value ?? 100)
        )))
    }

    func didSelect(image: UIImage?) {
        self.imageSection.reload()
        self.image = image
        self.imageSection.reload()
        self.navigationItem.rightBarButtonItem?.isEnabled = !(self.image == nil)
    }
}
