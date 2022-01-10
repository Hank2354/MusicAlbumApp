//
//  LoginViewController.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 02.12.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    var loginView: LoginView!
    
    @objc private func backButtonAction()   {
        self.dismiss(animated: true)
    }
    
    @objc private func loginButtonAction()  {
        
        guard let email = loginView.emailTF.text,
              let password = loginView.passwordTF.text,
                  email != "",
                  password != "" else {
                      loginView.generalWarnLabel.text = "Enter your email and password"
                      loginView.generalWarnLabel.alpha = 1
                      return
                  }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard error == nil,
                  user != nil else {
                      self?.loginView.generalWarnLabel.text = "Incorrect email or password"
                      self?.loginView.generalWarnLabel.alpha = 1
                      return
                  }
            
            let vc = AlbumsViewController()
            let nvc = AlbumNavigationController(navigationBarClass: AlbumNavigationBar.self, toolbarClass: nil)
            nvc.setViewControllers([vc], animated: true)
            nvc.modalPresentationStyle = .fullScreen
            
            self?.presentingViewController?.show(nvc, sender: self)
            
        }
    }
    
    override func loadView()                {
        self.view = LoginView()
    }

    override func viewDidLoad()             {
        super.viewDidLoad()
        loginView = self.view as? LoginView
        
        loginView.configure()
        
        loginView.backButtomTarget(self, action: #selector(backButtonAction))
        loginView.loginButtomTarget(self, action: #selector(loginButtonAction))
        
    }
}
