//
//  BuyButtonView.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/12.
//

import SwiftUI

struct BuySongButton: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let price = price {
            BuyButtonView(urlString: urlString, price: price, currency: currency)
        } else {
            Text("Album Only")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}


struct BuyButtonView: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let url = URL(string: urlString), let priceString = formattedPrice() {
            Link(destination: url) {
                Text(priceString)
            }
            .buttonStyle(BuyButtonStyle())
        }
    }
    
    func formattedPrice() -> String? {
        guard let price = price, price > 0 else {
            return nil
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        let priceString = formatter.string(from: NSNumber(value: price))
        return priceString
    }
}

struct BuyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let example = Song.example()
        BuyButtonView(urlString: example.collectionViewURL ?? "", price: example.trackPrice, currency: example.currency)
    }
}
