//
//  FetchState.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/07.
//

import Foundation

enum FetchState: Comparable {
    case idle
    case isLoading
    case loadedAll
    case error(String)
}
