//
//  User.swift
//  Objectiver
//
//  Created by Борис Вашов on 16.10.2021.
//

import Foundation

struct User: Identifiable, Decodable {
    var id: Int
    var phone: Int
    var givenName: String?
    var familyName: String?
    var about: String?
    var roles: [String]
}
