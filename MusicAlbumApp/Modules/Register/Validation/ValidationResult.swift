//
//  ValidationResult.swift
//  textFieldsValidTEST
//
//  Created by Vladislav Mashkov on 29.11.2021.
//

import Foundation

// Validation result model for error processing
struct ValidationResult {
    var isSuccses: Bool
    var error: String?
    
    init(isSuccses: Bool = true, error description: String? = nil) {
        self.isSuccses = isSuccses
        self.error = description
    }
}
