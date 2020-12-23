//
//  MovieViewModel.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/21/20.
//

import PromiseKit

class MovieViewModel {

    private let movieModel: MovieModel

    var id: Int32?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var voteAverage: Int16?

    init(movieModel: MovieModel) {
        self.movieModel = movieModel
        id = movieModel.id
        originalTitle = movieModel.originalTitle
        overview = movieModel.overview
        posterPath = movieModel.posterPath
        releaseDate = movieModel.releaseDate
        title = movieModel.title
        voteAverage = movieModel.voteAverage
    }

    static func popular() -> Promise<[MovieViewModel]> {
        return MovieModel.popular().map { $0.map { MovieViewModel(movieModel: $0) } }
    }

    static func upcoming() -> Promise<[MovieViewModel]> {
        return MovieModel.upcoming().map { $0.map { MovieViewModel(movieModel: $0) } }
    }

    static func topRated() -> Promise<[MovieViewModel]> {
        return MovieModel.topRated().map { $0.map { MovieViewModel(movieModel: $0) } }
    }

    static func favorite() -> Promise<[MovieViewModel]> {
        return MovieModel.favorite().map { $0.map { MovieViewModel(movieModel: $0) } }
    }

    func createFavorite() -> Promise<MovieViewModel> {
        return movieModel.createFavorite().map { MovieViewModel(movieModel: $0)}
    }

    func deleteFavorite() -> Promise<Void> {
        return movieModel.deleteFavorite()
    }

}

