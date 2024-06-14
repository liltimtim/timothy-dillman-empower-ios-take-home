//
//  Beneficiary.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation
struct Beneficiary: Decodable {
    let lastName: String
    let firstName: String
    let designationCode: String
    let beneType: String
    let socialSecurityNumber: String
    let dateOfBirth: String
    let middleName: String
    let phoneNumber: String
    let beneficiaryAddress: Address
    
    
    enum DesignationCode: String {
        case P = "P"
        case C = "C"
        case noneType = "---"
        
        func display() -> String {
            switch self {
            case .P: return "Primary"
            case .C: return "Contingent"
            default: return "---" // if server ever returns something we don't know about, return ---
            }
        }
    }
}

// MARK: - Beneficiary Computed extension properties

extension Beneficiary {
    var disignationCodeDisplay: DesignationCode {
        guard let dCode = DesignationCode(rawValue: designationCode) else { return .noneType }
        return dCode
    }
    var fullName: String { return "\(firstName) \(middleName) \(lastName)"}
    var dateOfBirthDisplay: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMddyyyy"
        guard let date = formatter.date(from: dateOfBirth) else { return nil }
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
}
