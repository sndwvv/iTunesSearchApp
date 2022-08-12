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
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchSongs(for: term)
        }.store(in: &subscriptions)
    }
    
    func clear() {
        state = .idle
        page = 0
        songs = []
    }
    
    func loadMore() {
        fetchSongs(for: searchTerm)
    }
    
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
                    print("Could not load: \(error.localizedDescription)")
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func example() -> SongListViewModel {
        let viewModel = SongListViewModel()
        viewModel.songs = [Song.example()]
        return viewModel
    }
}
