//
//  AlbumDetailView.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/13.
//

import SwiftUI

struct AlbumDetailView: View {
    
    let album: Album
    
    @StateObject var songsViewModel: SongsForAlbumDetailViewModel
    
    init(album: Album) {
        self.album = album
        self._songsViewModel = StateObject(wrappedValue: SongsForAlbumDetailViewModel(albumID: album.id))
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                ImageLoadingView(urlString: album.artworkUrl100, size: 100)
                VStack(alignment: .leading) {
                    Text(album.collectionName)
                        .font(.footnote)
                        .foregroundColor(Color(.label))
                    Text(album.artistName)
                        .padding(.bottom, 5)
                        
                    Text(album.primaryGenreName)
                    Text("\(album.trackCount) songs")
                    Text("Released: \(formattedDate(value: album.releaseDate ?? ""))")
                    
                }
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)

                Spacer(minLength: 20)
                BuyButtonView(urlString: album.collectionViewURL, price: album.collectionPrice, currency: album.currency)
            }
            .padding()
            
            SongsForAlbumDetailView(songsViewModel: songsViewModel)
        }
        .onAppear {
            songsViewModel.fetchSongs()
        }
    }
    
    func formattedDate(value: String) -> String {
        let dateFormatterGetter = DateFormatter()
        dateFormatterGetter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        guard let date = dateFormatterGetter.date(from: value) else {
            return ""
        }
        let dateFormatterSetter = DateFormatter()
        dateFormatterSetter.locale = Locale.current
        dateFormatterSetter.dateStyle = .medium
        dateFormatterSetter.timeStyle = .none
        return dateFormatterSetter.string(from: date)
    }
    
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album.example())
    }
}
