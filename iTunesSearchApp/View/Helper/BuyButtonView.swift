//
//  BuyButtonView.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/12.
//

import SwiftUI

struct BuyButtonView: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let url = URL(string: urlString), let price = price {
            Link(destination: url) {
                Text("\(Int(price)) \(currency)")
            }
            .buttonStyle(BuyButtonStyle())
        }
    }
}

struct BuyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let example = Song.example()
        BuyButtonView(urlString: example.previewURL, price: example.trackPrice, currency: example.currency)
    }
}
