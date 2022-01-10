//
//  AboutAlbumView.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 05.12.2021.
//

import UIKit

class DetailAlbumView: UIScrollView {
    
    // MARK: - Creating UI Elements
    private var albumImageView:     UIImageView              =  {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var activityIndicator:  UIActivityIndicatorView  =  {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var albumNameLabel:     UILabel                  =  {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "defaultOrangeColor")
        label.font = .boldSystemFont(ofSize: 25)
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    private var groupNameLabel:     UILabel                  =  {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "defaultOrangeColor")
        label.font = .boldSystemFont(ofSize: 18)
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    private var relizeDateLabel:    UILabel                  =  {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "defaultOrangeColor")
        label.font = .boldSystemFont(ofSize: 18)
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    private var tracksLabel:        UILabel                  =  {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "defaultOrangeColor")
        label.font = .boldSystemFont(ofSize: 22)
        label.text = ""
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    // MARK: - Cunfigurate elements methods
    
    private func fetchImage(urlAsStringToImage: String)                  {
        
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
                self.activityIndicator.stopAnimating()
            }
            
        }
        
        
    }
    
    private func setDateOfRelease(date: String)                          {
        let releaseDate = date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: releaseDate)
        guard let date = date else { return }
        formatter.dateFormat = "dd.MM.yyyy"
        let currentDate = formatter.string(from: date)
        relizeDateLabel.text = "Date of release: \(currentDate)"
    }
    
    private func createTrackLabel(trackName name: String) -> UILabel     {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "defaultOrangeColor")
        label.font = .boldSystemFont(ofSize: 14)
        label.text = name
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }
    
    private func addConstraints()                                        {
        self.addSubview(albumImageView)
        self.albumImageView.addSubview(activityIndicator)
        self.addSubview(albumNameLabel)
        self.addSubview(groupNameLabel)
        self.addSubview(relizeDateLabel)
        self.addSubview(tracksLabel)
        
        // All constraints
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(albumImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30))
        constraints.append(albumImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80))
        constraints.append(albumImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80))
        constraints.append(albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor))
        
        constraints.append(activityIndicator.centerXAnchor.constraint(equalTo: albumImageView.centerXAnchor))
        constraints.append(activityIndicator.centerYAnchor.constraint(equalTo: albumImageView.centerYAnchor))
        
        constraints.append(albumNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 5))
        constraints.append(albumNameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(albumNameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(albumNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        
        constraints.append(groupNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(groupNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 20))
        
        constraints.append(relizeDateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(relizeDateLabel.topAnchor.constraint(equalTo: groupNameLabel.bottomAnchor, constant: 20))
        
        constraints.append(tracksLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(tracksLabel.topAnchor.constraint(equalTo: relizeDateLabel.bottomAnchor, constant: 20))
        
       
        
        // Activate constraits
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func setTracks(tracks: [Tracks])                             {
        
        // Get tracks count
        let countOfTracks = tracks.count

        // Create empty array with labels
        var trackLabels = [UILabel]()
        
        // create labels in the cycle
        for index in 0..<countOfTracks {
            let label = createTrackLabel(trackName: tracks[index].trackName)
            trackLabels.append(label)
        }
        
        // create scrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.layer.borderWidth = 1
        scrollView.layer.borderColor = UIColor(named: "defaultOrangeColor")?.cgColor
        
        // createStackView with tracks labels
        let tracksStackView = UIStackView(arrangedSubviews: trackLabels)
        tracksStackView.distribution = .fillEqually
        tracksStackView.translatesAutoresizingMaskIntoConstraints = false
        tracksStackView.spacing = 5
        tracksStackView.axis = .vertical
        
        // Add scrollView as subview of main view, also add stackView in the scrollView
        self.addSubview(scrollView)
        scrollView.addSubview(tracksStackView)
        
        // Setup constraints
        
        // All constraints
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(scrollView.topAnchor.constraint(equalTo: tracksLabel.bottomAnchor, constant: 20))
        constraints.append(scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        constraints.append(scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20))
        
        constraints.append(tracksStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5))
        constraints.append(tracksStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5))
        constraints.append(tracksStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -5))
        constraints.append(tracksStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -5))
        
        // Activate constraits
        NSLayoutConstraint.activate(constraints)
        
    }
    
    // MARK: - Methods to access from ViewController (Encapsulation principle)
    func configure()                                                     {
        self.backgroundColor = UIColor(named: "defaultBlackColor")
        addConstraints()
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func updateInterface(detailAlbumModel detailAlbum: DetailAlbumModel) {
        albumNameLabel.text = detailAlbum.collectionName
        groupNameLabel.text = detailAlbum.artistName
        tracksLabel.text = "Tracks: "
        fetchImage(urlAsStringToImage: detailAlbum.imageURL)
        setDateOfRelease(date: detailAlbum.releaseDate)
        setTracks(tracks: detailAlbum.tracks)
       
    }

}
