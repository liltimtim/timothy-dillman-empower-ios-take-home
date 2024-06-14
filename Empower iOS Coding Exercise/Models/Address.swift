//
//  Address.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation
import Contacts
struct Address: Decodable {
    let mailingLine1: String   // Rename from firstLineMailing to mailingLine1
    let mailingLine2: String?  // Rename from scndLineMailing to mailingLine2
    let city: String
    let zipCode: String
    let stateCode: String
    let country: String
    
    private enum CodingKeys: String, CodingKey {
        case mailingLine1 = "firstLineMailing"
        case mailingLine2 = "scndLineMailing"
        case city
        case zipCode
        case stateCode
        case country
    }
}

extension Address {
    var addressFormatted: String {
        let placemark = CNMutablePostalAddress()
        placemark.street = "\(mailingLine1) \(mailingLine2 ?? "")"
        placemark.city = city
        placemark.state = stateCode
        placemark.country = country
        placemark.postalCode = zipCode
        let formatter = CNPostalAddressFormatter()
        return formatter.string(from: placemark)
    }
}
