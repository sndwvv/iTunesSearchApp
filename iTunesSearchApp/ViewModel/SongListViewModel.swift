//
//  SongListViewModel.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/07.
//

import Foundation
import Combine

class SongListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var songs: [Song] = [Song]()
    @Published var state: FetchState = .idle
    
    let limit: Int = 20
    var page: Int = 0
    private let service = APIService()
    
    var subscriptions = Set<AnyCancellable>()
    
    func fetchSongs(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        guard state == .idle else {
            return
        }
        state = .isLoading
        
        service.fetchSongs(searchTerm: searchTerm, page: page, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    for song in result.results {
                        self?.songs.append(song)
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
