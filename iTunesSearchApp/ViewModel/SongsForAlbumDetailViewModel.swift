//
//  SongsForAlbumDetailViewModel.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/13.
//

import Foundation

class SongsForAlbumDetailViewModel: ObservableObject {
    
    let albumID: Int
    @Published var songs = [Song]()
    @Published var state: FetchState = .idle
    
    private let service = APIService()
    
    init(albumID: Int) {
        self.albumID = albumID
        print("init for songs for album \(albumID)")
    }
    
    func fetchSongs() {
        fetchSongs(for: albumID)
    }
    
    private func fetchSongs(for albumID: Int) {
        state = .isLoading
        
        service.fetchSongs(for: albumID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self?.removeAlbumTypeFromResults(result: result)
                    self?.state = .loadedAll
                case .failure(let error):
                    print("Could not load: \(error)")
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
    
    func removeAlbumTypeFromResults(result: SongResult) {
        // API returns mixed results with "collection" and "track"
        // we only need "track" results for songs
        self.songs = result.results.filter { $0.wrapperType == "track" }
    }
    
    static func example() -> SongsForAlbumDetailViewModel {
        let vm = SongsForAlbumDetailViewModel(albumID: 1)
        vm.songs = [Song.example()]
        return vm 
    }
    
}
