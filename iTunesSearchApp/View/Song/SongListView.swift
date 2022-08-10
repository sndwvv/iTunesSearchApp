//
//  SongListView.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/10.
//

import SwiftUI

struct SongListView: View {
    
    @ObservedObject var viewModel: SongListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.songs) { song in
                Text(song.trackName)
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
        .searchable(text: $viewModel.searchTerm)
    }
}

struct SongListView_Previews: PreviewProvider {
    static var previews: some View {
        SongListView(viewModel: SongListViewModel())
    }
}
