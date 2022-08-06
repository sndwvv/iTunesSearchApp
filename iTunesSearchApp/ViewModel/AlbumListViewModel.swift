//
//  AlbumListViewModel.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/06.
//

import Foundation
import Combine

// https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5

class AlbumListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = []
    
    let limit: Int = 20
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
            self?.fetchAlbum(for: term)
        }.store(in: &subscriptions)
    }
    
    func fetchAlbum(for searchTerm: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("url session error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async {
                        self.albums = result.results
                    }
                } catch {
                    print("decoding error: \(error)")
                }
            }
        }.resume()
    }
    
}

