//
//  FileDataStoreTests.swift
//  Empower iOS Coding ExerciseTests
//
//  Created by Timothy Dillman on 6/14/24.
//

import XCTest
// I have mixed feelings about the "@testable" decorator here...
// in Swift the default is typically scoped to the module the class or struct is defined in.
// with testable though, the test acts as if it is apart of the module even though it isn't.
// If I were making a Swift Package, this "cheat code" would be deceiving because without using "public", callers of the package will not be able to access classes and structs but tests would.
// Ideally I would have packaged the business logic into a package and shipped it seperate but given the amount of time
// I do not have the time to do that and the requirements said "do not depend on 3rd party packages".
@testable import Empower_iOS_Coding_Exercise

final class FileDataStoreTests: XCTestCase {
    var sut: DataStore!
    let givenStore = MockReader()
    override func setUp() {
        super.setUp()
        sut = FileDataStore(store: givenStore)
    }
    
    func test_readsAndReturnsDecodableFromStore() async {
        // when
        do {
            // we use generic casting here to hint to the compiler
            // that we are wanting an array of beneficiary type
            // because we use generics, the casting is done for us.
            let results: [Beneficiary] = try await sut.readFromStore()
            XCTAssertEqual(results.count, 2)
            // grab first result and ensure it exists otherwise fail this test
            // we have a guarantee the first result will be "Smith"
            // arrays in JSON are guaranteed to return in the order unlike a dictionary.
            guard let example1 = results.first else {
                XCTFail("Was expecting result size of at least 1 got 0.")
                return
            }
            // we are just testing that one property is parsed correctly
            // it can be argued that this is a bad test because this does not relate to the current SUT which is the `FileDataStore`
            // I personally just like to do some sanity checks and having extra can't hurt.
            XCTAssertEqual(example1.lastName, "Smith")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
}
