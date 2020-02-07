//
//  CloudWorker.swift
//  Feed
//
//  Created by Ehud Adler on 2/5/20.
//  Copyright © 2020 Ehud Adler. All rights reserved.
//

import UIKit
import CloudKit

struct NewThreadCreationError : Error {}

final class CloudWorker {

    //MARK: - Private iVars
    private let database = CKContainer.default().publicCloudDatabase

    //MARK: - Singleton
    public static let shared = CloudWorker()
    private init() {}

    //MARK: - Public methods


    /// Query the public database for a feed by its uid
    /// - Parameters:
    ///   - uid: Unique ID (RecordName)
    ///   - completionHandler: Returns the all feeds that match the uid or and error if one occurs
    public func queryFeed(uid: String, completionHandler: @escaping (Result<[Feed], Error>) -> Void) {
        let query = CKQuery(recordType: Record.Types.Feed, predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, error) in

            if let error = error {
                performOnBackground {
                    completionHandler(.failure(error))
                }
                return
            }

            guard let records = records else {
                performOnBackground {
                    completionHandler(.failure(NewThreadCreationError()))
                }
                return
            }

            let sortedRecords = records.sorted (by: { $0.creationDate! > $1.creationDate! } )

            do {
                let data: [Feed] = try sortedRecords.compactMap({
                    guard let content = $0.value(forKey:  Record.Keys.Feed.content) as? Data else { return nil }
                    return try Feed.decode(data: content)
                })
                completionHandler(.success(data))
            } catch let error {
                completionHandler(.failure(error))
            }
        }
    }


    public func updateFeed(uid: String, newFeed: Feed) {}


    /// Creates a new feed record in the database and returns its uid
    /// - Parameters:
    ///   - content: Feed content to store
    ///   - completionHandler: Returns the uid upon success or an error if one occurs
    public func newFeed(newFeed content: Feed, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let newThread = CKRecord(recordType: Record.Types.Feed)
        do {
            let encodedData = try content.encode()
            newThread.setValue(encodedData, forKey: Record.Keys.Feed.content)
            database.save(newThread) { (record, error) in

                if let error = error {
                    performOnBackground {
                        completionHandler(.failure(error))
                    }
                    return
                }

                guard let record = record else {
                    performOnBackground {
                        completionHandler(.failure(NewThreadCreationError()))
                    }
                    return
                }

                performOnBackground {
                    completionHandler(.success(record.recordID.recordName))
                }
            }
        } catch let error {
            completionHandler(.failure(error))
        }
    }
}
