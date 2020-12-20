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

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        originalTitle <- map["original_title"]
    }

}
