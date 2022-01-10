//
//  ValidationTextField.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 02.12.2021.
//

import UIKit

class ValidationTextField: UITextField {

    // Type of textField, will set after init
    var validateType: ValidateType = .none
    
    // Validation text in a textField by validation type
    func isValid() -> ValidationResult {
        return validateType.isValid(text: self.text)
    }
    
    // Validation another text by validation type
    func isValidWithUpdatingText(updatedText: String?) -> ValidationResult {
        return validateType.isValid(text: updatedText)
    }
    
    var warnLabel: UILabel!
    
    // Valid status (default false)
    var valid: Bool = false

}
