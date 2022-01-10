//
//  ValidateType.swift
//  textFieldsValidTEST
//
//  Created by Vladislav Mashkov on 29.11.2021.
//

import Foundation

enum ValidateType {
    // Create validation types
    case name
    case yearsOld
    case phoneNumber
    case email
    case password
    case none
    
    // Depending on the type we actiate valid method from string extension
    func isValid(text: String?) -> ValidationResult {
        guard let text = text else { return .init(isSuccses: false, error: "Can't be empty")}
        
        switch self {
        case .name: return text.isValidName
        case .yearsOld: return text.isValidYearsOld
        case .phoneNumber: return text.isValidPhoneNumber
        case .email: return text.isValidEmail
        case .password: return text.isValidPassword
        case .none: return ValidationResult(isSuccses: false, error: "Default case do not support validation")
        }
    }
}

