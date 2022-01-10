//
//  AboutUserViewController.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 05.12.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AboutUserViewController: UIViewController {
    
    var aboutUserView: AboutUserView!
    
    var ref: DatabaseReference!
    
    private func getUserSettings(completion: @escaping (UserModel) -> ())  {
        guard let currentUser = Auth.auth().currentUser else { return }
        
        var user: UserModel!
        user = UserModel(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid))
        ref.observe(.value) { snapshot in
            guard let snapshotValue = snapshot.value as? [String : String] else { return }
            user.name = snapshotValue["First Name"]
            user.secondName = snapshotValue["Second Name"]
            user.yearsOld = snapshotValue["Date of birthday"]
            user.phoneNumber = snapshotValue["Phone number"]
            completion(user)
        }
    }
    
    override func loadView()                                               {
        super.loadView()
        
        self.view = AboutUserView()
    }

    override func viewDidLoad()                                            {
        super.viewDidLoad()
        
        aboutUserView = self.view as? AboutUserView
        aboutUserView.configure()
        getUserSettings { userModel in
            self.aboutUserView.setupLabels(user: userModel)
        }
    }
    
}
