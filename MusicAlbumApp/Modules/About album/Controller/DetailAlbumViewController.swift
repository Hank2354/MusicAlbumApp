//
//  AboutAlbumViewController.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 05.12.2021.
//

import UIKit

class DetailAlbumViewController: UIViewController {
    
    let networkManager     =    NetworkManager()
    
    var album:                  AlbumModel!
    
    var detailAlbum:            DetailAlbumModel!

    private var aboutAlbumView: DetailAlbumView!
    
    private var albumImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "defaultAlbumImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func loadView()                  {
        super.loadView()
        
        self.view = DetailAlbumView()
    }

    override func viewDidLoad()               {
        super.viewDidLoad()
        
        aboutAlbumView = self.view as? DetailAlbumView
        
        aboutAlbumView.configure()
        
        // get data for album id
        networkManager.fetchDetailDataOfAlbum(collectionID: album.collectionID) { aboutAlbumModel in
            
            // create empty array with track as Tracks and relizeDate variable
            var interTracksArray = [Tracks]()
            var releaseDate: String = "Unknow"
            
            for result in aboutAlbumModel.results {
                // if we get collection in the cycle, save release date
                if result.wrapperType == .collection {
                    let relize = result.releaseDate ?? "Unknow"
                    releaseDate = relize
                } else {
                    // get trackname or save "Unknow" if we can't get it
                    let trackName: String = result.trackName ?? "Unknow"
                    // create track with trackName
                    let track = Tracks(trackName: trackName)
                    // append track in tracks array
                    interTracksArray.append(track)
                }
                
            }
            
            // After cycle create detail model of Album with default init
            self.detailAlbum = DetailAlbumModel(collectionName: self.album.collectionName,
                                              artistName: self.album.artistName,
                                              imageURL: self.album.imageURL,
                                              releaseDate: releaseDate,
                                              tracks: interTracksArray)
            
            // Update interface in a main queue
            DispatchQueue.main.async {
                self.aboutAlbumView.updateInterface(detailAlbumModel: self.detailAlbum)
            }
            
        }
    }
}
