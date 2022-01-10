//
//  AlbumNavigationBar.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 02.12.2021.
//

import UIKit

class AlbumNavigationBar: UINavigationBar {
    
    var logoImageView:    UIImageView      =  {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "smallLogoImage")
        
        return image
    }()
    
    var signOutButton:    UIBarButtonItem  =  {
        let button = UIBarButtonItem()
        
        button.title = "SignOut"
        button.tintColor = UIColor(named: "defaultOrangeColor")
        
        return button
    }()
    
    var aboutUserButton:  UIBarButtonItem  =  {
        let button = UIBarButtonItem()
        
        button.tintColor = UIColor(named: "defaultOrangeColor")
        button.image = UIImage(named: "userDataImageLogo")
        
        return button
    }()

    // Method to configurate us navigationBar
    func configure()  {
        self.tintColor = UIColor(named: "defaultOrangeColor")
        self.isTranslucent = true
        
        // Add items in navigationBar
        self.topItem?.titleView = logoImageView
        self.topItem?.leftBarButtonItem = signOutButton
        self.topItem?.rightBarButtonItem = aboutUserButton
    }
    
    func aboutUserButtonTarget(_ target: AnyObject?, action: Selector) {
        aboutUserButton.target = target
        aboutUserButton.action = action
    }
    
    func signOutButtonTarget(_ target: AnyObject?, action: Selector)   {
        signOutButton.target = target
        signOutButton.action = action
    }
    
}
