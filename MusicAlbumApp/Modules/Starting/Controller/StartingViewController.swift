//
//  StartingViewController.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 30.11.2021.
//

import Foundation
import UIKit

class StartingViewController: UIViewController {
    
    var startingView: StartingView!
    
    @objc private func loginButtonAction()     {
        let loginVC = LoginViewController()
        self.navigationController?.present(loginVC, animated: true, completion: nil)
    }
    
    @objc private func registerButtonAction()  {
        let registerVC = RegisterViewController()
        self.navigationController?.present(registerVC, animated: true, completion: nil)
    }
    
    override func loadView()                   {
        self.view = StartingView()
    }
    
    override func viewDidLoad()                {
        super.viewDidLoad()
        startingView = self.view as? StartingView
        
        startingView.configure()
        
        self.navigationController?.isNavigationBarHidden = true
        
        // Add targets
        startingView.addLoginButtomTarget(self, action: #selector(loginButtonAction))
        startingView.addRegisterButtomTarget(self, action: #selector(registerButtonAction))
        
    }
    
    
}
