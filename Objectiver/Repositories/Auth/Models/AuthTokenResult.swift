//
//  AuthTokenResult.swift
//  Objectiver
//
//  Created by Борис Вашов on 16.10.2021.
//

import Foundation

class AuthTokenResult: Decodable {
    var accessToken: String
    var userId: Int
    var roles: [String]
}
