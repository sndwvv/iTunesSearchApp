//
//  APIError.swift
//  iTunesSearchApp
//
//  Created by Songyee Park on 2022/08/07.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case urlSession(URLError?)
    case badResponse(Int)
    case decoding(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
        case .badURL:
            return "bad URL"
        case .urlSession(let error):
            return "urlSession error: \(error.debugDescription)"
        case .badResponse(let statusCode):
            return "bad response with status code: \(statusCode)"
        case .decoding(let decodingError):
            return "decoding error: \(String(describing: decodingError))" 
        case .unknown:
            return "unknown error"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .badURL, .unknown, .badResponse(_):
            return "something went wrong"
        case .urlSession(let error):
            return error?.localizedDescription ?? "something went wrong"
        case .decoding(let decodingError):
            return decodingError?.localizedDescription ?? "seomthing went wrong"
        }
    }
}
