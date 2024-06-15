//
//  FileStoreReaderTests.swift
//  Empower iOS Coding ExerciseTests
//
//  Created by Timothy Dillman on 6/14/24.
//

import XCTest
@testable import Empower_iOS_Coding_Exercise
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
    
    func test_canReadFileWithKnownFileExistingInBundle() async {
        // given when and then
        let results = try? await sut.read(storeName: "beneficiaries")
//        XCTAssertNotNil(try? await sut.read(storeName: "beneficiaries"))
    }
    
    func test_ensureEmptyStoreNameThrowsError() async {
        // given
        let givenStoreName = ""
        
        // when and then
        do {
            _ = try await sut.read(storeName: givenStoreName)
            XCTFail()
        } catch {
            XCTAssertEqual(error.localizedDescription, StoreReaderErrors.emptyStoreName.localizedDescription)
        }
    }
    
    func test_validBundleWithoutResourceThrowsError() async {
        // given
        
        // create specialized one off bundle
        let bundle = Bundle()
        let givenStoreName = "beneficiaries"
        
        // when
        
        // create new system under test (sut) with custom bundle
        sut = FileStoreReader(with: bundle)
        do {
            _ = try await sut.read(storeName: givenStoreName)
        } catch {
            // then
            XCTAssertEqual(error.localizedDescription, StoreReaderErrors.invalidPathURL(name: givenStoreName).localizedDescription)
        }
    }
}
