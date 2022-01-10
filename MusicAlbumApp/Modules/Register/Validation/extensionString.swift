//
//  extensionString.swift
//  textFieldsValidTEST
//
//  Created by Vladislav Mashkov on 29.11.2021.
//

import Foundation

extension String {
    
    // Validation logic for textField with type as .name
    var isValidName: ValidationResult          {
        // получаем текст из строки
        let actualString = self
        
        guard actualString.count >= 2 else { return ValidationResult(isSuccses: false, error: "Must be 2 characters or more") }
        guard actualString.count <= 20 else { return ValidationResult(isSuccses: false, error: "No more than 20 characters") }
        // создаем регулярное выражение
        let nameRegex = "[A-za-z\\s]+$"
        // создаем предикат
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        
        if namePred.evaluate(with: actualString) {
            return ValidationResult(isSuccses: true, error: nil)
        } else {
            return ValidationResult(isSuccses: false, error: "Only English language")
        }
    }
    
    // Validation logic for textField with type as .yearsOld
    var isValidYearsOld: ValidationResult      {
        // получаем текст из строки
        let actualString = self
        
        // создаем dateformatter и устанавливаем формат даты какой нам нужен
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        // получаем дату рождения
        let birthday = formatter.date(from: actualString)
        
        // получаем интервал в секундах от даты рождения до актуальной даты
        let timeInterval = birthday?.timeIntervalSinceNow
        // получаем возраст, делим количество прожитых секунд в году и убираем минус (особенность работы временного интервала
        let age = (timeInterval! / 31556926.0) * (-1)
        
        // если возраст меньше 18, то поле не валидно, если больше - то поле валидно
        if age < 18 {
            return ValidationResult(isSuccses: false, error: "Only 18+")
        }
        return ValidationResult(isSuccses: true, error: nil)
    }
    
    // Validation logic for textField with type as .phoneNumber
    var isValidPhoneNumber: ValidationResult   {
        // получаем текст из строки
        let actualString = self

        // создаем регулярное выражение
        let nameRegex = "^\\+7{1} \\([0-9]{3}\\) [0-9]{3}\\-[0-9]{2}\\-[0-9]{2}$"
        // создаем предикат
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        
        if namePred.evaluate(with: actualString) {
            return ValidationResult(isSuccses: true, error: nil)
        } else {
            return ValidationResult(isSuccses: false, error: "Incorrect phone number")
        }
    }
    
    // Validation logic for textField with type as .email
    var isValidEmail: ValidationResult         {
        // получаем текст из строки
        let actualString = self
        // создаем регулярное выражение
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        // создаем предикат
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if emailPred.evaluate(with: actualString) {
            return ValidationResult(isSuccses: true, error: nil)
        } else {
            return ValidationResult(isSuccses: false, error: "Incorrect email")
        }
    }
    
    // Validation logic for textField with type as .password
    var isValidPassword: ValidationResult      {
        // сохраняем текст из строки
        let actualString = self
        
        // минимальное количество символов в пароле
        let minLenght = 6
        
        // проверка на содержание минимального количества символов в тексте
        guard actualString.count >= minLenght else { return ValidationResult(isSuccses: false,
                                                                             error: "Не менее 6 символов")}
        
        // регулярное выражение, проверяющее:
        /// 1 символ нижнего регистра
        /// 1 символ верхнего регистра
        /// 1 цифру
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[0-9])[A-Za-z\\d$@$!%*?&]{0,}"
        
        // создаем предикат
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        
        if passwordPred.evaluate(with: actualString) {
            return ValidationResult(isSuccses: true, error: nil)
        } else {
            return ValidationResult(isSuccses: false, error: "Пароль должен содержать маленькую букву, большую букву, и цифру")
        }
    }
    
    // Pattern for create mask of phoneNumber
    func applyPatternOnNumbers(pattern: String,
                               replacmentCharacter: Character) -> String {
        // Create numbers from text
        var pureNumber = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // in the cycle, replace the character to be replaced with the number from the pureNumber (above)
        for index in 0 ..< pattern.count {
            
            guard index < pureNumber.count else { return pureNumber }
            
            let stringIndex = String.Index(utf16Offset: index, in: self)
            
            let patternCharacter = pattern[stringIndex]
            
            guard patternCharacter != replacmentCharacter else { continue }
            
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        
        return pureNumber
    }
    
}
