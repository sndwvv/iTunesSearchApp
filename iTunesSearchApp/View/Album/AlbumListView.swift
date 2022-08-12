//
//  AlbumListView.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/06.
//

import SwiftUI

struct AlbumListView: View {
    
    @ObservedObject var viewModel: AlbumListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.albums) { album in
                AlbumRowView(album: album)
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




struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView(viewModel: AlbumListViewModel())
    }
}
