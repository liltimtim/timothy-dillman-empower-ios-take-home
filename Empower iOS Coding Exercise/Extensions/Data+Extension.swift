//
//  Data+Extension.swift
//  Empower iOS Coding Exercise
//
//  Created by Timothy Dillman on 6/14/24.
//

import Foundation

/**
 A protocol that defines a transformation method for decoding data into a specified type.
 */
public protocol Transformable {
    /**
     Transforms the data into an instance of the specified type.

     - Parameter type: The type to decode the data into.

     - Throws: An error of type `DecodingError` if the data cannot be decoded.

     - Returns: An instance of the specified type decoded from the data.

     ### Usage Example:
     ```swift
     /// Define a struct representing a user profile.
     struct UserProfile: Decodable {
         let username: String
         let email: String
         let bio: String?
     }

     /// Example JSON data representing a user profile.
     let jsonData = """
     {
         "username": "johndoe",
         "email": "johndoe@example.com",
         "bio": "I like video games! :)"
     }
     """.data(using: .utf8)!

     do {
         /// Decode JSON data into a `UserProfile` instance using the `transforming(type:)` method.
         let userProfile = try jsonData.transforming(type: UserProfile.self)
         print(userProfile)
     } catch {
         print("Error decoding JSON: \(error)")
     }
     ```
     */
    func transforming<T: Decodable>(type: T.Type) throws -> T
}

extension Data: Transformable {
    /**
     Transforms the data into an instance of the specified type using JSON decoding.
     
     - Parameter type: The type to decode the data into.
     
     - Throws: An error of type `DecodingError` if the data cannot be decoded.
     
     - Returns: An instance of the specified type decoded from the data.
     */
    public func transforming<T>(type: T.Type) throws -> T where T : Decodable {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
