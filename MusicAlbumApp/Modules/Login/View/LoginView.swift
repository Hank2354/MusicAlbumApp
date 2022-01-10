//
//  LoginView.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 02.12.2021.
//

import UIKit

class LoginView: UIView {

    // MARK: - Creating UI Elements
    private var backgroundImageView:  UIImageView  = {
        let imageView = UIImageView(image: UIImage(named: "secondBackgroundImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var logoImageView:        UIImageView  = {
        let imageView = UIImageView(image: UIImage(named: "logoImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var backButton:           UIButton     = {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = nil
        
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = UIColor(named: "defaultOrangeColor")
        
        return button
    }()
    
    private var loginButton:          UIButton     = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = nil
        
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        
        button.backgroundColor = UIColor(named: "defaultOrangeColor")
        
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }()
    
    var emailTF:           UITextField!
    
    var passwordTF:        UITextField!
    
    var generalWarnLabel:  UILabel!
    
    // MARK: - Methods to generated TextFields and WarnLabel in the login panel
    
    private func createTextField(placeholder: String) -> ValidationTextField  {
        let textField = ValidationTextField()
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
        let placeholder = NSAttributedString(string: placeholder,
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.attributedPlaceholder = placeholder
        
        textField.backgroundColor = UIColor.white
        
        textField.textColor = UIColor(named: "defaultBlackColor")
        
        textField.keyboardType = .default
        
       
        return textField
    }
    
    private func createWarnLabel() -> UILabel                                 {
        let label = UILabel()
        
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Only English"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        
        return label
    }
    
    // MARK: - Methods to setup layout settings for UI elements and login panel
    private func setupBackgroundImage()                                       {
        
        self.addSubview(backgroundImageView)
        
        // All constraints
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor))
        constraints.append(backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        constraints.append(backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor))
        constraints.append(backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor))
        
        // Activate constraits
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupLogoImage()                                             {
        
        self.addSubview(logoImageView)
        
        // All constraints
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(logoImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(logoImageView.widthAnchor.constraint(equalToConstant: 50))
        constraints.append(logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: 17.0/21.0))
        
        // Activate constraits
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupBackButton()                                            {
        
        self.addSubview(backButton)
        
        // All constraints
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30))
        constraints.append(backButton.widthAnchor.constraint(equalToConstant: 30))
        constraints.append(backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor))
        
        // Activate constraits
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupLoginPanel()                                            {
        // Creating TextFields
        let emailTextField = createTextField(placeholder: "Email")
        let passwordTextField = createTextField(placeholder: "Password")
        let warnLabel = createWarnLabel()
        warnLabel.alpha = 0
        passwordTextField.isSecureTextEntry = true
        
        emailTF = emailTextField
        passwordTF = passwordTextField
        generalWarnLabel = warnLabel
        
        // Creating registrationPanelStackView with another stackViews
        let registerPanelStackView = UIStackView(arrangedSubviews: [warnLabel,
                                                                    emailTextField,
                                                                    passwordTextField])
        
        registerPanelStackView.distribution = .fillEqually
        registerPanelStackView.translatesAutoresizingMaskIntoConstraints = false
        registerPanelStackView.spacing = 30
        registerPanelStackView.axis = .vertical
        
        self.addSubview(registerPanelStackView)
        self.addSubview(loginButton)
        
        // Variable with constraints
        var constraints = [NSLayoutConstraint]()
        
        // Add constraints to array
        constraints.append(registerPanelStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100))
        constraints.append(registerPanelStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30))
        constraints.append(registerPanelStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30))
        constraints.append(registerPanelStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -80))
        constraints.append(emailTextField.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(loginButton.topAnchor.constraint(equalTo: registerPanelStackView.bottomAnchor, constant: 40))
        constraints.append(loginButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 70))
        constraints.append(loginButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -70))
        constraints.append(loginButton.heightAnchor.constraint(equalToConstant: 45))
        constraints.append(loginButton.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        
        // Activate all constraits
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Methods to access from ViewController (Encapsulation principle)
    func configure()                                                          {
        
        setupBackgroundImage()
        setupLogoImage()
        setupBackButton()
        setupLoginPanel()
    }
    
    func backButtomTarget(_ target: Any?, action: Selector)                   {
        backButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func loginButtomTarget(_ target: Any?, action: Selector)                  {
        loginButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    

}
