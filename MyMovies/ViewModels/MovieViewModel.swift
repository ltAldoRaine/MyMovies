//
//  MovieViewModel.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/21/20.
//

import PromiseKit

class MovieViewModel {

    private let movieModel: MovieModel?

    var id: Int16?
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

    static func allFavorites() -> [MovieViewModel]? {
        guard var all = MovieModel.allFavorites() else { return nil }
        //sorty by release date
        all.sort { (movieModel1, movieModel2) -> Bool in
            if let date1 = movieModel1.releaseDate?.toDate(format: "yyyy-MM-dd"), let date2 = movieModel2.releaseDate?.toDate(format: "yyyy-MM-dd") {
                return date1 > date2
            }
            return false
        }
        return all.map { MovieViewModel(movieModel: $0) }
    }

    func createFavorite(success: ((_ movieViewModel: MovieViewModel?) -> Void)? = nil, failure: (() -> Void)? = nil) {
        movieModel?.createFavorite(success: success, failure: failure)
    }

    func deleteFavorite(success: (() -> Void)? = nil, failure: (() -> Void)? = nil) {
        movieModel?.deleteFavorite(success: success, failure: failure)
    }

}

