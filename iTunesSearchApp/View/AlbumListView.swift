//
//  AlbumListView.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/06.
//

import SwiftUI

struct AlbumListView: View {
    
    @StateObject var viewModel = AlbumListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.albums) { album in
                Text(album.collectionName)
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Albums")
        }

    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
