//
//  AlbumsView.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 02.12.2021.
//

import UIKit

class AlbumsTableView: UITableView {
    
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "secondBackgroundImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = true
        return imageView
    }()
    
    func configure() {
        self.backgroundView = backgroundImageView
    }

}
