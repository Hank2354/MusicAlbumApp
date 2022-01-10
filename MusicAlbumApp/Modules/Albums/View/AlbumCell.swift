//
//  AlbumsCell.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 02.12.2021.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    // MARK: - Creating UI Elements
    private var albumImageView:    UIImageView  =  {
        let imageView = UIImageView(image: UIImage(named: "defaultAlbumImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var albumNameLabel:    UILabel      =  {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "defaultOrangeColor")
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Album name"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    private var groupNameLabel:    UILabel      =  {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "defaultOrangeColor")
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Group name"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    private var countTracksLabel:  UILabel      =  {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "defaultOrangeColor")
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "21 Tracks"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    // MARK: - Methods to setup layout settings and fetch image with GCD
    private func addConstraints()                         {
        
        self.addSubview(albumImageView)
        self.addSubview(albumNameLabel)
        self.addSubview(groupNameLabel)
        self.addSubview(countTracksLabel)
        
        // All constraints
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(albumImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 2))
        constraints.append(albumImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -2))
        constraints.append(albumImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor))
        
        constraints.append(albumNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5))
        constraints.append(albumNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 5))
        
        constraints.append(groupNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 5))
        constraints.append(groupNameLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 5))
        
        constraints.append(countTracksLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5))
        constraints.append(countTracksLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 5))
        
        // Activate constraits
        NSLayoutConstraint.activate(constraints)
    }
    
    private func fetchImage(urlAsStringToImage: String)   {
        
        DispatchQueue.global(qos: .utility).async {
            guard let imageURL = URL(string: urlAsStringToImage),
                  let imageData = try? Data(contentsOf: imageURL) else {
                      DispatchQueue.main.async {
                          self.albumImageView.image = UIImage(named: "defaultAlbumImage")
                      }
                      return
                  }
            DispatchQueue.main.async {
                self.albumImageView.image = UIImage(data: imageData)
            }
            
        }
        
        
    }
    
    // MARK: - Methods to access from ViewController (Encapsulation principle)
    func setupCellsWithDataModel(albumModel: AlbumModel)  {
        albumNameLabel.text = albumModel.collectionName
        groupNameLabel.text = albumModel.artistName
        countTracksLabel.text = "\(albumModel.trackCount) Tracks"
        fetchImage(urlAsStringToImage: albumModel.imageURL)
    }
    
    func configure()                                      {
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.backgroundColor = UIColor.clear
        addConstraints()
    }
}
