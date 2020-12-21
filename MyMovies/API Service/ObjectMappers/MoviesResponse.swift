//
//  MoviesResponse.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/20/20.
//

import ObjectMapper

class MoviesResponse: Mappable {

    var results: [MovieModel]?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        results <- map["results"]
    }

}
