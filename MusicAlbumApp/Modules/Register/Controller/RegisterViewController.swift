//
//  RegisterViewController.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 02.12.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    var ref: DatabaseReference!

    var registerView: RegisterView!
    
    @objc private func backButtonAction()                        {
        self.dismiss(animated: true)
    }
    
    @objc private func registerButtonAction()                    {
        
        // try get test from all textFields
        guard let firstName = self.registerView.firstNameTextField.text,
              let secondName = self.registerView.secondNameTextField.text,
              let yearsOld = self.registerView.yearsOldTextField.text,
              let phoneNumber = self.registerView.phoneNumberTextField.text,
              let email = self.registerView.emailTextField.text,
              let password = self.registerView.passwordTextField.text else { return }
        
        // Create user with texts from textFields
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (userData, error) in
            // If we get error, we show alertController with error text
            guard error == nil,
                  userData != nil else {
                      guard let error = error else { return }
                      self?.showWarnAlertController(withText: error.localizedDescription)
                      return
                  }
            
            // Get path to user directory of database
            let userRef = self?.ref.child((userData?.user.uid)!)
            
            // set values for save in database
            userRef?.setValue(["First Name" : firstName,
                               "Second Name" : secondName,
                               "Date of birthday" : yearsOld,
                               "Phone number" : phoneNumber,
                               "Email" : (userData?.user.email)!,
                               "Password" : password])
            
            // create vc and show vc from presentingViewController
            let vc = AlbumsViewController()
            let nvc = AlbumNavigationController(navigationBarClass: AlbumNavigationBar.self, toolbarClass: nil)
            nvc.setViewControllers([vc], animated: true)
            nvc.modalPresentationStyle = .fullScreen
            
            self?.presentingViewController?.show(nvc, sender: self)
        }
        
        
        
        
        
    }
    
    @objc private func getDataFromDatePicker()                   {
        
        // create formatter and set dateFormat
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        // set formated date for yeardOldTextField
        registerView.yearsOldTextField.text = formatter.string(from: registerView.datePicker.date)
        
        // get validationResult
        let validationResult = registerView.yearsOldTextField.isValid()
        
        // if succses validation set valid style for textField, save valid status and disable warnLabel
        if validationResult.isSuccses {
            
            registerView.setValidStyleForTextField(tf: registerView.yearsOldTextField)
            registerView.yearsOldTextField.warnLabel.alpha = 0
            registerView.yearsOldTextField.valid = true
            
        } else {
            
            // else set invalid style and save valid status, also show warn label with error text, if we got it
            registerView.setInvalidStyleForTextField(tf: registerView.yearsOldTextField)
            registerView.yearsOldTextField.valid = false
            if let error = validationResult.error {
                registerView.yearsOldTextField.warnLabel.text = error
                registerView.yearsOldTextField.warnLabel.alpha = 1
            }
            
        }
    }
    
    private func setupDelegatesAndTargets()                      {
        
        // Setup delegates
        registerView.firstNameTextField.delegate = self
        registerView.secondNameTextField.delegate = self
        registerView.yearsOldTextField.delegate = self
        registerView.phoneNumberTextField.delegate = self
        registerView.emailTextField.delegate = self
        registerView.passwordTextField.delegate = self
        
        // Setup targets
        registerView.backButtomTarget(self, action: #selector(backButtonAction))
        registerView.registerButtonTarget(self, action: #selector(registerButtonAction))
        registerView.datePicketAddTarget(self, action: #selector(getDataFromDatePicker))
    }
    
    private func showWarnAlertController(withText text: String)  {
        // Create and present default alert Controller with one button (without login, only for present error information)
        let ac = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        ac.addAction(okButton)
        
        self.present(ac, animated: true, completion: nil)
    }
    
    override func loadView()                                     {
        self.view = RegisterView()
    }

    override func viewDidLoad()                                  {
        super.viewDidLoad()
        registerView = self.view as? RegisterView
        
        registerView.configure()
        setupDelegatesAndTargets()
        
        // save path to users directory in database
        ref = Database.database().reference(withPath: "users")
        
        
    }

}

// MARK: - Validation
extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Checking for the correct textField class
        guard let validationTextField = textField as? ValidationTextField else { return false }
        
        // For yeardOldTextField (TextField with .yeardsOld type) We forbid entering with keyboard
        if validationTextField.validateType == .yearsOld {
            return false
        }
        
        // Get text from textField
        let text = textField.text! as NSString
        
        // Get the text that should be obtained after adding changes by the user
        var updatedText = text.replacingCharacters(in: range, with: string)
        
        // For phoneNumber we apply us pattern
        if validationTextField.validateType == .phoneNumber {
            // If textField is clear we added +7 in a field
            if validationTextField.text == "" {
                updatedText = "+7 \(updatedText.applyPatternOnNumbers(pattern: "+# (###) ###-##-##", replacmentCharacter: "#"))"
            }
            // else just apply pattern
            updatedText = "\(updatedText.applyPatternOnNumbers(pattern: "+# (###) ###-##-##", replacmentCharacter: "#"))"
            
        }
        
        // Get result by validation with updated text
        let validationResult = validationTextField.isValidWithUpdatingText(updatedText: updatedText)
        
        // We implement a logic depending on the validation result
        if validationResult.isSuccses {
            
            // if valid is succses set valid style for textField and disable warn label, also save valid status in textField
            registerView.setValidStyleForTextField(tf: validationTextField)
            validationTextField.warnLabel.alpha = 0
            validationTextField.valid = true
            
            // For the phoneNumber text field we add updated text with settings from mask to interface and forbid entering with keyboard
            if validationTextField.validateType == .phoneNumber {
                validationTextField.text = updatedText
                return false
            }
            
        } else {
            // Else we set invalid style and if we get error, show it on warnLabel, and enable warnLabel also save invalid status
            registerView.setInvalidStyleForTextField(tf: validationTextField)
            
            if let error = validationResult.error {
                validationTextField.warnLabel.text = error
                validationTextField.warnLabel.alpha = 1
            }
            
            validationTextField.valid = false
            
            if validationTextField.validateType == .phoneNumber {
                validationTextField.text = updatedText
                return false
            }
            
        }

        // If all textField have valid status - enable register button
        if registerView.firstNameTextField.valid &&
            registerView.secondNameTextField.valid &&
            registerView.yearsOldTextField.valid &&
            registerView.phoneNumberTextField.valid &&
            registerView.emailTextField.valid &&
            registerView.passwordTextField.valid {
            
            registerView.registerButton.isEnabled = true
            registerView.setValidStyleForRegisterButton()
        } else {
            // else disable register button
            registerView.registerButton.isEnabled = false
            registerView.setInvalidStyleForRegisterButton()
        }
        
        // after working code add updates from user in textField
        return true
        
    }
    
}
