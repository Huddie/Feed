//
//  FeedImageCell.swift
//  Feed
//
//  Created by Ehud Adler on 1/4/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit

final class FeedImageCell: UITableViewCell, FeedableCell {

    //MARK: - FeedableCell 
    typealias Model = FeedableImageModel
    var model: FeedableImageModel?

    //MARK: - Private iVars
    private let asyncImageView: AsyncImageView = .init(cache: FeedImageCache.shared)

    //MARK: - Public inits
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, model: FeedableModel) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    //MARK: - Private methods
    private func setUpImageView() {
        addSubview(asyncImageView)
        asyncImageView.translatesAutoresizingMaskIntoConstraints = false

        if let height = model?.height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        NSLayoutConstraint.activate([
           asyncImageView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
           asyncImageView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
           asyncImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
           asyncImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    //MARK: - FeedableCell Methods
    func configure(model: FeedableModel)  {
        guard let model = model as? FeedableImageModel else { return }
        self.model = model
        asyncImageView.setImage(forKey: model.url)
        setUpImageView()
    }
}

