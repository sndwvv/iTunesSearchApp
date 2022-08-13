//
//  SongsForAlbumDetailView.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/13.
//

import SwiftUI

struct SongsForAlbumDetailView: View {
   
    @ObservedObject var songsViewModel: SongsForAlbumDetailViewModel
    
    var body: some View {
        ScrollView {
            switch songsViewModel.state {
            case .isLoading:
                ProgressView()
                    .progressViewStyle(.circular)
            case .loadedAll:
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(songsViewModel.songs) { song in
                        HStack {
                            Text(String(song.trackNumber ?? 0))
                                .font(.footnote)
                                .frame(width: 25, alignment: .trailing)
                                
                            Text(song.trackName ?? "")
                            
                            Spacer()
                            
                            Text(formattedDuration(time: song.trackTimeMillis ?? 0))
                                .font(.footnote)
                                .frame(width: 50, alignment: .center)
                            
                            BuySongButton(urlString: song.previewURL ?? "", price: song.trackPrice, currency: song.currency)
                        }
                        Divider() 
                    }
                }
                .padding([.vertical, .trailing], 15)
            case .error(let error):
                Text(error.description)
            case .idle:
                EmptyView()
            }
        }
    }
    
    func formattedDuration(time: Int) -> String {
        let timeInSeconds = time / 1000
        let interval = TimeInterval(timeInSeconds)
        let formatter = DateComponentsFormatter()
        return formatter.string(from: interval) ?? ""
    }
}

struct SongsForAlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongsForAlbumDetailView(songsViewModel: SongsForAlbumDetailViewModel.example())
    }
}
