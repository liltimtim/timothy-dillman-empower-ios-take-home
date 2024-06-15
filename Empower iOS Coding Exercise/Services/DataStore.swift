//
//  DataStore.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation

protocol DataStore {
    init(store: some StoreReader)
    func readFromStore<T: Decodable>() async throws -> T
}

// MARK: - Data Store Types

/**
 `FileDataStore` is a type of store that can read on-disk data.
 */
class FileDataStore {
    private var store: StoreReader
    
    required init(store: some StoreReader) {
        self.store = store
    }
}

extension FileDataStore: DataStore {
    func readFromStore<T>() async throws -> T where T : Decodable {
        do {
            let data = try await store.read(storeName: "beneficiaries")
            guard let result = try data?.transforming(type: T.self) as? T else {
                throw FileDataStoreErrors.decodingError
            }
            return result
        }
    }
}

enum FileDataStoreErrors: Error, LocalizedError {
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .decodingError: return "Error trying to decode object."
        }
    }
}
