//
//  PasswordValidator.swift
//  Objectiver
//
//  Created by Борис Вашов on 18.10.2021.
//

import Foundation

class PasswordValidator {
    static func isValid(_ password: String) -> Bool {
        !password.isEmpty
    }
}
