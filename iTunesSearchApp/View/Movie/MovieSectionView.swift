//
//  MovieSectionView.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/12.
//

import SwiftUI

struct MovieSectionView: View {
    
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(movies) { movie in
                    VStack(alignment: .leading) {
                        ImageLoadingView(urlString: movie.artworkUrl100, size: 100)
                        Text(movie.trackName)
                        Text(movie.primaryGenreName)
                            .foregroundColor(.gray)
                    }
                    .lineLimit(2)
                    .frame(width: 100)
                    .font(.caption)
                }
                .padding([.horizontal, .bottom])
            }
        }
    }
}

struct MovieSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSectionView(movies: [Movie.example()])
    }
}
