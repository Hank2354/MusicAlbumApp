//
//  NetworkManager.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 04.12.2021.
//

import Foundation

class NetworkManager {
    
    // Fetch data of AlbumDataModel
    func fetchData(albumName name: String, completion: @escaping (AlbumDataModel) -> ())                   {
        let urlString: String = "https://itunes.apple.com/search?term=\(name)&entity=album&attribute"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) {  data, response, error in
            guard let data = data, error == nil else { return }
            guard let albumData = self.parseJSON(data: data) else { return }
            completion(albumData)
        }
        
        task.resume()
    }
    
    // Fetch data of DetailAlbumDataModel
    func fetchDetailDataOfAlbum(collectionID id: Int, completion: @escaping (DetailAlbumDataModel) -> ())  {
        let urlString: String = "https://itunes.apple.com/lookup?id=\(id)&entity=song"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) {  data, response, error in
            guard let data = data, error == nil else { return }
            guard let detailAlbumData = self.parseJSONTwo(data: data) else { return }
            completion(detailAlbumData)
        }
        
        task.resume()
    }
    
    private func parseJSON(data: Data) -> AlbumDataModel?           {
        let decoder = JSONDecoder()
        
        do {
            let albumData = try decoder.decode(AlbumDataModel.self, from: data)
            return albumData
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    private func parseJSONTwo(data: Data) -> DetailAlbumDataModel?  {
        let decoder = JSONDecoder()
        
        do {
            let albumData = try decoder.decode(DetailAlbumDataModel.self, from: data)
            return albumData
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
        
    }
}
