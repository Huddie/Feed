//
//  FeedableFullModel.swift
//  Feed
//
//  Created by Ehud Adler on 1/29/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import Foundation

struct FeedableModelWrapper: Codable {

    //MARK: - Internal iVars
    let type: Feedables
    let feedableModel: FeedableModel

    //MARK: - Public inits
    init(type: Feedables, model: FeedableModel) {
        self.type = type
        self.feedableModel = model
    }


    //MARK: - Codable
    enum ModelKeys: String, CodingKey {
        case feedableModel
    }

    enum TypeKey: String, CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let typeObj = try decoder.container(keyedBy: TypeKey.self)
        let ModelObj = try decoder.container(keyedBy: ModelKeys.self)

        let rawType = try typeObj.decode(String.self, forKey: .type)
        let rawFeedableModel = try ModelObj.decode(String.self, forKey: .feedableModel)

        type = Feedables(rawValue: rawType) ?? .blank

        switch type {
        case .image:
            feedableModel = rawFeedableModel.jsonDecode(to: FeedableImageModel.self)!
        case .text:
            feedableModel = rawFeedableModel.jsonDecode(to: FeedableTextModel.self)!
        default:
            throw GenerateFeedableError()
        }
    }

    func encode(to encoder: Encoder) throws {
        var typeObj = encoder.container(keyedBy: TypeKey.self)
        var ModelObj = encoder.container(keyedBy: ModelKeys.self)

        try typeObj.encode("\(type)", forKey: .type)
        try ModelObj.encode(feedableModel.encodeContent(), forKey: .feedableModel)
    }
}
