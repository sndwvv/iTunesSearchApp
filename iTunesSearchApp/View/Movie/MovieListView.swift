//
//  MovieListView.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/07.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var viewModel: MovieListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.movies) { movie in
                MovieRowView(movie: movie)
            }
            switch viewModel.state {
            case .idle:
                Color.clear
                    .onAppear {
                        viewModel.loadMore() 
                    }
            case .isLoading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
            case .loadedAll:
                Color.gray
            case .error(let message):
                Text(message)
                    .foregroundColor(.red)
            }

        }
        .listStyle(.plain) 
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieListViewModel())
    }
}
