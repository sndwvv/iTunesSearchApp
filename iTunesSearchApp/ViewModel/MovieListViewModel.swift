//
//  MovieListViewModel.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/07.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var movies: [Movie] = [Movie]()
    @Published var state: FetchState = .idle
    
    private let service = APIService()
    
    var subscriptions = Set<AnyCancellable>()
    let defaultLimits: Int = 50
    
    init() {
        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchMovies(for: term)
        }.store(in: &subscriptions)
    }
    
    func clear() {
        state = .idle
        movies = []
    }
    
    func loadMore() {
        fetchMovies(for: searchTerm)
    }
    
    func fetchMovies(for searchTerm: String) {
        guard !searchTerm.isEmpty else {
            return
        }
        guard state == .idle else {
            return
        }
        state = .isLoading
        
        service.fetchMovies(searchTerm: searchTerm) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self?.movies = result.results
                    if result.resultCount == self?.defaultLimits {
                        self?.state = .idle
                    } else {
                        self?.state = .loadedAll
                    }
                case .failure(let error):
                    print(error.description)
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func example() -> MovieListViewModel {
        let viewModel = MovieListViewModel()
        viewModel.movies = [Movie.example()]
        return viewModel
    }
}
