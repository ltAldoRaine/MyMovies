//
//  Network.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/19/20.
//

import UIKit

class Network {

    static let moviesApirUrl = "https://api.themoviedb.org/3"
//    static let moviesApiKey = "76f96247f4450927937cf79fab4d97e9"

    static func moviePoster(_ posterPath: String) -> String {
        return "https://image.tmdb.org/t/p/original\(posterPath)"
    }

}
