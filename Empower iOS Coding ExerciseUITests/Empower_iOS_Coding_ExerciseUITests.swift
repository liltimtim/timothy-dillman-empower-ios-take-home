//
//  Empower_iOS_Coding_ExerciseUITests.swift
//  Empower iOS Coding ExerciseUITests
//
//  Created by Timothy Dillman on 6/14/24.
//

import XCTest

final class Empower_iOS_Coding_ExerciseUITests: XCTestCase {
    func test_selectBeneficiaryFromList() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables["beneficiary_list_table"]
        let cell = tablesQuery.cells["beneficiary_0_1"]
        cell.tap()
    }
    
    func test_selectBeneficiaryValidateDetails() throws {
        let app = XCUIApplication()
        app.launch()
        // grab first cell tap it
        app.tables["beneficiary_list_table"].cells["beneficiary_0_0"].tap()
        
        // validate details page information
        let ssnLabel = app.staticTexts["social_security_number_label"]
        XCTAssertTrue(ssnLabel.exists)
        XCTAssertEqual(ssnLabel.label, "Social Security Number: XXXXX3333")
        let dobLabel = app.staticTexts["date_of_birth_label"]
        XCTAssertTrue(dobLabel.exists)
        XCTAssertEqual(dobLabel.label, "Birthday 04/20/1979")
        let phoneLabel = app.staticTexts["phone_number_label"]
        XCTAssertTrue(phoneLabel.exists)
        let addressLabel = app.staticTexts["address_label"]
        XCTAssertTrue(addressLabel.exists)
    }
}
