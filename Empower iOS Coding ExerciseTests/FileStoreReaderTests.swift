//
//  FileStoreReaderTests.swift
//  Empower iOS Coding ExerciseTests
//
//  Created by Timothy Dillman on 6/14/24.
//

import XCTest
import Empower_iOS_Coding_Exercise
final class FileStoreReaderTests: XCTestCase {
    var sut: StoreReader!
    var givenBundle: Bundle!
    override func setUp() {
        super.setUp()
        // grab main application bundle
        givenBundle = Bundle(identifier: "com.timothydillman.Empower-iOS-Coding-Exercise")
        sut = FileStoreReader(with: givenBundle)
    }

    override func tearDown() {
        sut = nil
        givenBundle = nil
        super.tearDown()
    }
    
    func test_canReadFileWithKnownFileExistingInBundle() {
        // given when and then
        XCTAssertNotNil(try? sut.read(storeName: "beneficiaries"))
    }
    
    func test_ensureEmptyStoreNameThrowsError() {
        // given
        let givenStoreName = ""
        
        // when and then
        XCTAssertThrowsError(try sut.read(storeName: givenStoreName))
    }
    
    func test_validBundleWithoutResourceThrowsError() {
        // given
        
        // create specialized one off bundle
        let bundle = Bundle()
        let givenStoreName = "beneficiaries"
        
        // when
        
        // create new system under test (sut) with custom bundle
        sut = FileStoreReader(with: bundle)
        
        // then
        XCTAssertThrowsError(try sut.read(storeName: givenStoreName))
    }

}
