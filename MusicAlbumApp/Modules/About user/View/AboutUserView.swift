//
//  AboutUserView.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 05.12.2021.
//

import UIKit

class AboutUserView: UIView {
    
    // MARK: - Creating UI Elements
    private var activityIndicator: UIActivityIndicatorView  =  {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Methods to support configurate view
    private func setupActivityIndicator()                      {
        self.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func createLabel(withText text: String) -> UILabel {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "defaultOrangeColor")
        label.font = .boldSystemFont(ofSize: 18)
        label.text = text
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }

    // MARK: - Methods to access from ViewController (Encapsulation principle)
    func setupLabels(user: UserModel)                          {
        
        guard let name = user.name,
              let secondName = user.secondName,
              let yearsOld = user.yearsOld,
              let phoneNumber = user.phoneNumber else { return }
        
        let fullname = "\(name) \(secondName)"
        
        let nameLabel = createLabel(withText: fullname)
        let yearsOldLabel = createLabel(withText: yearsOld)
        let phoneNumberLabel = createLabel(withText: phoneNumber)
        let emailLabel = createLabel(withText: user.email)
        
        let generalStackView = UIStackView(arrangedSubviews: [nameLabel,
                                                              yearsOldLabel,
                                                              phoneNumberLabel,
                                                              emailLabel])
        generalStackView.spacing = 10
        generalStackView.distribution = .fillEqually
        generalStackView.translatesAutoresizingMaskIntoConstraints = false
        generalStackView.axis = .vertical
        
        self.addSubview(generalStackView)
        
        // All constraints
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(generalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100))
        constraints.append(generalStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(generalStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 20))
        
        
        // Activate constraits
        NSLayoutConstraint.activate(constraints)
        
        activityIndicator.stopAnimating()
    }
    
    func configure()                                           {
        self.backgroundColor = UIColor(named: "defaultBlackColor")
        setupActivityIndicator()
    }
    

}
