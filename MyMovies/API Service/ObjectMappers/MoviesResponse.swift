//
//  MoviesResponse.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/20/20.
//

import ObjectMapper

class MoviesResponse: Mappable {

    var results: [Movie]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        results <- map["results"]
    }

}

class Movie: Mappable {

    var posterPath: String?
    var title: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        posterPath <- map["poster_path"]
        title <- map["title"]
    }

}
