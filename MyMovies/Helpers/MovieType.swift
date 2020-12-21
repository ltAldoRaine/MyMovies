//
//  MovieType.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/20/20.
//

import Foundation

enum MovieType: CustomStringConvertible {

    case popular
    case upcoming
    case topRated
    case favorite

    var description: String {
        switch self {
        case .popular:
            return "Popular"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top Rated"
        case .favorite:
            return "Favorite"
        }
    }

}
