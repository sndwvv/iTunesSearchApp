//
//  AlbumListViewModel.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/06.
//

import Foundation
import Combine

class AlbumListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    @Published var state: FetchState = .idle
    
    let limit: Int = 20
    var page: Int = 0
    let service = APIService()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchAlbums(for: term)
        }.store(in: &subscriptions)
    }
    
    func clear() {
        state = .idle
        page = 0
        albums = []
    }
    
    func loadMore() {
        fetchAlbums(for: searchTerm)
    }
    
    func fetchAlbums(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        guard state == .idle else {
            return
        }
        state = .isLoading
        
        service.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    for album in result.results {
                        self?.albums.append(album)
                    }
                    self?.page += 1
                    self?.state = (result.results.count == self?.limit) ? .idle : .loadedAll
                case .failure(let error):
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }

}

