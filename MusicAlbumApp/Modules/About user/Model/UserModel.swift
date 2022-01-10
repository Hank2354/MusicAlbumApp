//
//  UserModel.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 05.12.2021.
//

import Foundation
import Firebase
import FirebaseAuth

struct UserModel {
    var uid: String
    var name: String?
    var secondName: String?
    var yearsOld: String?
    var phoneNumber: String?
    var email: String
    
    // init with user object (firebase)
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
        
        self.name = nil
        self.secondName = nil
        self.yearsOld = nil
        self.phoneNumber = nil
    }
}
