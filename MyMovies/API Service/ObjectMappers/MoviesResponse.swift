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

    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var voteAverage: Int?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
        title <- map["title"]
        voteAverage <- map["vote_average"]
    }

}
