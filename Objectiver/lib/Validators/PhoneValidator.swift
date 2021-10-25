//
//  LoginValidator.swift
//  Objectiver
//
//  Created by Борис Вашов on 18.10.2021.
//

import Foundation

class PhoneValidator {
    static func isValid(_ phoneNumber: String) -> Bool {
        let num = Int(phoneNumber) ?? 0
        print(num)
        return num != 0
    }
}
