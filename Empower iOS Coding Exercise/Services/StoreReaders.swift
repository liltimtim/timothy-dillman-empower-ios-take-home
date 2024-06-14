//
//  StoreReaders.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation

// MARK: Store Reader Protocols

public protocol StoreReader {
    func read(storeName: String) throws -> Data?
}

// MARK: Reader Types

/**
 The reader type defined here is for reading data from local storage using application bundle
 */
public final class FileStoreReader: StoreReader {
    private var bundle: Bundle?
    
    /**
     Initializes `FileStoreReader` with the given bundle.
     
     - Parameter bundle: The bundle from which to read JSON files.
     */
    public init(with bundle: Bundle) {
        self.bundle = bundle
    }
    
    /**
     Reads data from a JSON file with the specified name.
     
     - Parameter storeName: The name of the JSON file to read.
     
     - Throws:
     - `StoreReaderErrors.invalidBundle`: If the `bundle` is `nil`.
     - `StoreReaderErrors.emptyStoreName`: If `storeName` is empty.
     - `StoreReaderErrors.invalidPathURL`: If the file specified by `storeName` does not exist in the bundle.
     
     - Returns: The data read from the JSON file.
     */
    public func read(storeName: String) throws -> Data? {
        // ensure given filename is not empty
        guard let bundle = self.bundle else { throw StoreReaderErrors.invalidBundle }
        guard !storeName.isEmpty else { throw StoreReaderErrors.emptyStoreName }
        do {
            guard let path = bundle.url(forResource: storeName, withExtension: "json") else { throw StoreReaderErrors.invalidPathURL(name: storeName) }
            let data = try Data(contentsOf: path)
            return data
        }
    }
}

// MARK: - Store Reader Errors

/**
 `StoreReaderErrors` enumerates errors that can occur during operations with `StoreReader` or its implementations.
 */
public enum StoreReaderErrors: Error, LocalizedError {
    /// Error thrown when an empty store name is given to `StoreReader`.
    case emptyStoreName
    
    /// Error thrown when `StoreReader` is initialized with an invalid bundle.
    case invalidBundle
    
    /**
     Error thrown when a file specified by `name` does not exist in the `bundle`.
     
     - Parameters:
     - name: The name of the file that does not exist.
     - bundle: The bundle where the file was expected to exist.
     */
    case fileDoesNotExist(name: String, bundle: Bundle)
    
    /**
     Error thrown when the path URL specified by `name` is invalid.
     
     - Parameter name: The name of the file with an invalid path URL.
     */
    case invalidPathURL(name: String)
    
    public var errorDescription: String? {
        switch self {
        case .emptyStoreName:
            return "Empty store name given to StoreReader"
        case .invalidBundle:
            return "Initialized with an Invalid Bundle"
        case .fileDoesNotExist(let name, let bundle):
            return "File with name \(name) does not exist in bundle \(bundle)"
        case .invalidPathURL(let name):
            return "\(name) is an invalid path"
        }
    }
}
