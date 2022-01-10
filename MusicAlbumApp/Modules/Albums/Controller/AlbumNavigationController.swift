//
//  AlbumNavigationController.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 02.12.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class AlbumNavigationController: UINavigationController {
    
    @objc private func aboutUserAction()                 {
        let vc = AboutUserViewController()
        show(vc, sender: self)
    }
    
    @objc private func signOutAction()                   {
        
        do {
            try Auth.auth().signOut()
            self.navigationBar.window?.rootViewController?.dismiss(animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
  
    }
    
    private func addTargets(navbar: AlbumNavigationBar)  {
        navbar.aboutUserButtonTarget(self, action: #selector(aboutUserAction))
        navbar.signOutButtonTarget(self, action: #selector(signOutAction))
    }

    override func viewDidLoad()                          {
        super.viewDidLoad()

        // Get us navigationBar with custom class and configurate it
        let navbar = self.navigationBar as? AlbumNavigationBar
        navbar?.configure()
        
        guard let navbar = navbar else { return }
        addTargets(navbar: navbar)
        
        
    }


}
