//
//  AlbumsViewController.swift
//  MusicAlbumApp
//
//  Created by Vladislav Mashkov on 02.12.2021.
//

import UIKit

class AlbumsViewController: UIViewController {

    // Get us tableView
    var albumsTableView: AlbumsTableView!
    
    // Create empty array with albums
    var albumArray = [AlbumModel]()
    
    // get network manager
    let networkManager = NetworkManager()
    
    // create timer
    var timer = Timer()
    
    // Create search controller
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty:  Bool  {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering:       Bool  {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // setup searchController
    private func setupSearchController() {
        // Указываем, что получателем информации об изменении текста в нашей строке будет выступать наш класс
        searchController.searchResultsUpdater = self
        // Убираем ограничение на изменение данных, которые будем получать при поиске
        searchController.obscuresBackgroundDuringPresentation = false
        // устанавливаем placeholder
        searchController.searchBar.placeholder = "Поиск"
        // Присваиваем нашему навигейшн айтему наш серч контроллер
        self.navigationItem.searchController = searchController
        // Отпускаем строку поиска при переходе на другой экран
        definesPresentationContext = true
    }
    
    override func loadView()             {
        self.view = AlbumsTableView()
    }
    
    override func viewDidLoad()          {
        super.viewDidLoad()
        
        // нашей глобальной переменной присваиваем ссылку на вью, для того чтоб всегда иметь доступ к view в этом классе
        albumsTableView = self.view as? AlbumsTableView
        
        // register cell
        albumsTableView.register(AlbumCell.self, forCellReuseIdentifier: "cell")
        
        // Set delegates
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
        
        // метод кофигурации нашего tableView
        albumsTableView.configure()
        
        // Устанавливаем нашу поисковую строку
        setupSearchController()
        
    }

}

extension AlbumsViewController: UITableViewDelegate     {
    
}

extension AlbumsViewController: UITableViewDataSource   {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumCell
        
        cell.configure()
        cell.setupCellsWithDataModel(albumModel: albumArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailAlbumViewController()
        vc.album = albumArray[indexPath.row]
        show(vc, sender: self)
    }
    
    
}

// MARK: - SearchController logic
extension AlbumsViewController: UISearchResultsUpdating {
    
    // update after add characters in search bar
    func updateSearchResults(for searchController: UISearchController) {
        // get text from search bar
        guard let text = searchController.searchBar.text else { return }
        
        // reset timer
        timer.invalidate()
        
        // set code block to execute after timeInterval (second)
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.filtredContentForSearchText(text)
        })
    }
    
    // filtering logic
    private func filtredContentForSearchText(_ searchText: String) {
        let fetchText = searchText.replacingOccurrences(of: " ", with: "+")
        networkManager.fetchData(albumName: fetchText) { albumDataModel in
            var interAlbumArray = [AlbumModel]()
            for album in albumDataModel.results {
                let currentAlbum = AlbumModel(collectionID: album.collectionID,
                                              artistName: album.artistName,
                                              collectionName: album.collectionName,
                                              imageURL: album.artworkUrl100,
                                              trackCount: album.trackCount)
                interAlbumArray.append(currentAlbum)
            }
            DispatchQueue.main.async {
                self.albumArray = interAlbumArray
                self.albumsTableView.reloadData()
            }
        }
        
    }
    
    
}
