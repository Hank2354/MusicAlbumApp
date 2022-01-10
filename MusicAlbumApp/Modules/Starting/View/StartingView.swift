//
//  StartingView.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 30.11.2021.
//

import UIKit

class StartingView: UIView {
    
    // MARK: - Creating UI Elements
    private var backgroundImageView:  UIImageView  =  {
        let imageView = UIImageView(image: UIImage(named: "backgroundImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var loginButton:          UIButton     =  {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = nil
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "defaultOrangeColor")?.cgColor
        
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(named: "defaultOrangeColor"), for: .normal)
        
        return button
    }()
    
    private var registerButton:       UIButton     =  {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = nil
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "defaultOrangeColor")?.cgColor
        
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor(named: "defaultOrangeColor"), for: .normal)
        
        return button
    }()
    
    // MARK: - Methods to setup layout settings for UI elements
    private func setupBackgroundImage()                             {
        
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
    
    private func setupBottomButtons()                               {
        let buttomStackView = UIStackView(arrangedSubviews: [loginButton, registerButton])
        buttomStackView.distribution = .fillEqually
        buttomStackView.translatesAutoresizingMaskIntoConstraints = false
        buttomStackView.spacing = 20
        
        self.addSubview(buttomStackView)
        
        // All constraints
        var constraints = [NSLayoutConstraint]()
        
        // Add constraints
        constraints.append(buttomStackView.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(buttomStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -15))
        constraints.append(buttomStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 35))
        constraints.append(buttomStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -35))
        
        // Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Methods to access from ViewController (Encapsulation principle)
    func configure()                                                {
        setupBackgroundImage()
        setupBottomButtons()
    }
    
    func addLoginButtomTarget(_ target: Any?, action: Selector)     {
        loginButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func addRegisterButtomTarget(_ target: Any?, action: Selector)  {
        registerButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
}
