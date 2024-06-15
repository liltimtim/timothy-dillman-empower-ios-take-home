//
//  TestingUtils.swift
//  Empower iOS Coding ExerciseTests
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation
@testable import Empower_iOS_Coding_Exercise

class MockStore: DataStore {
    /// Set this value to ensure `readFromStore` throws an error
    var throwsError: Bool = false
    private var store: StoreReader
    
    required init(store: some StoreReader) {
        self.store = store
    }
    
    func readFromStore<T>() async throws -> T where T : Decodable {
        if throwsError {
            throw FileDataStoreErrors.decodingError
        }
        do {
            let data = try await store.read(storeName: "MockStoreName")
            guard let result = try data?.transforming(type: T.self) as? T else {
                throw FileDataStoreErrors.decodingError
            }
            return result
        }
    }
}

class MockReader: StoreReader {
    func read(storeName: String) throws -> Data? {
        return """
        [
          {
            "lastName": "Smith",
            "firstName": "John",
            "designationCode": "P",
            "beneType": "Spouse",
            "socialSecurityNumber": "XXXXX3333",
            "dateOfBirth": "04201979",
            "middleName": "D",
            "phoneNumber": "3035555555",
            "beneficiaryAddress": {
              "firstLineMailing": "8515 E Orchard Rd",
              "scndLineMailing": null,
              "city": "Greenwood Village",
              "zipCode": "80111",
              "stateCode": "CO",
              "country": "US"
            }
          },
          {
            "lastName": "Smith",
            "firstName": "Jane",
            "designationCode": "C",
            "beneType": "Child",
            "socialSecurityNumber": "XXXXX4664",
            "dateOfBirth": "01112012",
            "middleName": "E",
            "phoneNumber": "3034455555",
            "beneficiaryAddress": {
              "firstLineMailing": "8515 E Orchard Rd",
              "scndLineMailing": null,
              "city": "Greenwood Village",
              "zipCode": "80111",
              "stateCode": "CO",
              "country": "US"
            }
          }
        ]
        """.data(using: .utf8)
    }
}
