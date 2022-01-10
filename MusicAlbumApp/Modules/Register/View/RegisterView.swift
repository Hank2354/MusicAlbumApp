//
//  RegisterView.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 02.12.2021.
//

import UIKit

class RegisterView: UIView {
    
    // MARK: - Creating UI Elements
    private var backgroundImageView:  UIImageView  =  {
        let imageView = UIImageView(image: UIImage(named: "secondBackgroundImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var logoImageView:        UIImageView  =  {
        let imageView = UIImageView(image: UIImage(named: "logoImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var backButton:                   UIButton     =  {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = nil
        
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.tintColor = UIColor(named: "defaultOrangeColor")
        
        return button
    }()
    
    var registerButton:               UIButton     =  {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = nil
        
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        
        button.backgroundColor = UIColor.gray
        
        button.setTitle("Registration", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        
        return button
    }()
    
    var firstNameTextField:    ValidationTextField!
    
    var secondNameTextField:   ValidationTextField!
    
    var yearsOldTextField:     ValidationTextField!
    
    var phoneNumberTextField:  ValidationTextField!
    
    var emailTextField:        ValidationTextField!
    
    var passwordTextField:     ValidationTextField!
    
    var datePicker       =     UIDatePicker()
    
    // MARK: - Methods to generated TextFields and WarnLabels in the registration panel
    private func createStackView(subviews: [UIView]) -> UIStackView           {
        let resultStackView = UIStackView(arrangedSubviews: subviews)
        resultStackView.distribution = .fillEqually
        resultStackView.translatesAutoresizingMaskIntoConstraints = false
        resultStackView.spacing = -10
        resultStackView.axis = .vertical
        return resultStackView
    }
    
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
        label.font = .boldSystemFont(ofSize: 12)
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.alpha = 0
        
        return label
    }
    
    // MARK: - Methods to setup layout settings for UI elements and registration panel
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
    
    private func setupRegistrationPanel()                                     {
        // Creating TextFields
        let firstNameTextField = createTextField(placeholder: "First name")
        let secondNameTextField = createTextField(placeholder: "Second name")
        let yearsOldTextField = createTextField(placeholder: "Yeard old")
        let phoneNumberTextField = createTextField(placeholder: "Phone number")
        let emailTextField = createTextField(placeholder: "Email")
        let passwordTextField = createTextField(placeholder: "Password")
        
        // Creating WarnLabels
        let firstNameWarnLabel = createWarnLabel()
        let secondNameWarnLabel = createWarnLabel()
        let yearsOldWarnLabel = createWarnLabel()
        let phoneNumberWarnLabel = createWarnLabel()
        let emailWarnLabel = createWarnLabel()
        let passwordWarnLabel = createWarnLabel()
        
        // Setup TextFields Settings
        firstNameTextField.validateType = .name
        firstNameTextField.warnLabel = firstNameWarnLabel
        self.firstNameTextField = firstNameTextField
        
        secondNameTextField.validateType = .name
        secondNameTextField.warnLabel = secondNameWarnLabel
        self.secondNameTextField = secondNameTextField
        
        yearsOldTextField.validateType = .yearsOld
        yearsOldTextField.warnLabel = yearsOldWarnLabel
        self.yearsOldTextField = yearsOldTextField
        
        phoneNumberTextField.validateType = .phoneNumber
        phoneNumberTextField.warnLabel = phoneNumberWarnLabel
        self.phoneNumberTextField = phoneNumberTextField
        
        emailTextField.validateType = .email
        emailTextField.warnLabel = emailWarnLabel
        self.emailTextField = emailTextField
        
        passwordTextField.validateType = .password
        passwordTextField.warnLabel = passwordWarnLabel
        passwordTextField.isSecureTextEntry = true
        self.passwordTextField = passwordTextField
        
        
        // Creating StackViews with TextFiels and WarnLabels
        let firstNameStackView = createStackView(subviews: [firstNameWarnLabel, firstNameTextField])
        let secondNameStackView = createStackView(subviews: [secondNameWarnLabel, secondNameTextField])
        let yearsOldStackView = createStackView(subviews: [yearsOldWarnLabel, yearsOldTextField])
        let phoneNumberStackView = createStackView(subviews: [phoneNumberWarnLabel, phoneNumberTextField])
        let emailStackView = createStackView(subviews: [emailWarnLabel, emailTextField])
        let passwordStackView = createStackView(subviews: [passwordWarnLabel, passwordTextField])
        
        // Creating registrationPanelStackView with another stackViews
        let registerPanelStackView = UIStackView(arrangedSubviews: [firstNameStackView,
                                                                   secondNameStackView,
                                                                   yearsOldStackView,
                                                                   phoneNumberStackView,
                                                                   emailStackView,
                                                                   passwordStackView])
        // Setup general stackView settings
        registerPanelStackView.distribution = .fillEqually
        registerPanelStackView.translatesAutoresizingMaskIntoConstraints = false
        registerPanelStackView.spacing = 10
        registerPanelStackView.axis = .vertical
        
        self.addSubview(registerPanelStackView)
        self.addSubview(registerButton)
        
        // Variable with constraints
        var constraints = [NSLayoutConstraint]()
        
        // Add constraints to array
        constraints.append(registerPanelStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30))
        constraints.append(registerPanelStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30))
        constraints.append(registerPanelStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30))
        constraints.append(registerPanelStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -80))
        constraints.append(firstNameTextField.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(registerButton.topAnchor.constraint(equalTo: registerPanelStackView.bottomAnchor, constant: 20))
        constraints.append(registerButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 70))
        constraints.append(registerButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -70))
        constraints.append(registerButton.heightAnchor.constraint(equalToConstant: 45))
        constraints.append(registerButton.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        
        // Activate all constraits
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupDatePicker()                                            {
        
        // Datepicker settings
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: Locale.preferredLanguages.first!)
        datePicker.preferredDatePickerStyle = .inline
        
        // When user tapped on screen, Datepicker will be deinit
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.addGestureRecognizer(tapGesture)
        
        // Add datePicker to inputView of yeardOldTextField
        self.yearsOldTextField.inputView = datePicker
    }
    
    @objc private func tapGestureDone()                                       {
        self.endEditing(true)
    }
    
    // MARK: - Methods to access from ViewController (Encapsulation principle)
    func configure()                                                          {
        setupBackgroundImage()
        setupLogoImage()
        setupBackButton()
        setupRegistrationPanel()
        setupDatePicker()
        
        // Register button default status - Disabled
        self.registerButton.isEnabled = false
    }
    
    // Targets
    func backButtomTarget(_ target: Any?, action: Selector)                   {
        backButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func registerButtonTarget(_ target: Any?, action: Selector)               {
        registerButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func datePicketAddTarget(_ target: Any?, action: Selector)                {
        datePicker.addTarget(target, action: action, for: .valueChanged)
    }
    
    // Update text field interface by validate status
    func setValidStyleForTextField(tf: UITextField)                           {
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.green.cgColor
    }
    
    func setInvalidStyleForTextField(tf: UITextField)                         {
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.red.cgColor
    }
    
    func setValidStyleForRegisterButton()                                     {
        registerButton.backgroundColor = UIColor(named: "defaultOrangeColor")
        registerButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func setInvalidStyleForRegisterButton()                                   {
        registerButton.backgroundColor = UIColor.gray
        registerButton.setTitleColor(UIColor.black, for: .normal)
    }
    
}

