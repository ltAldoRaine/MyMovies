//
//  MovieModel.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/21/20.
//

import ObjectMapper
import CoreStore
import PromiseKit

class MovieModel: Mappable {

    private static let moviesAPI = MoviesAPI()

    var id: Int32?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var voteAverage: Int16?

    init(id: Int32? = nil, originalTitle: String? = nil, overview: String? = nil, posterPath: String? = nil, releaseDate: String? = nil, title: String? = nil, voteAverage: Int16? = nil) {
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.voteAverage = voteAverage
    }

    init(favoriteEntity: FavoriteEntity) {
        id = favoriteEntity.id
        originalTitle = favoriteEntity.originalTitle
        overview = favoriteEntity.overview
        posterPath = favoriteEntity.posterPath
        releaseDate = favoriteEntity.releaseDate
        title = favoriteEntity.title
        voteAverage = favoriteEntity.voteAverage
    }

    required init?(map: Map) {

    }

    static func popular() -> Promise<[MovieModel]> {
        return moviesAPI.popular()
    }

    static func upcoming() -> Promise<[MovieModel]> {
        return moviesAPI.upcoming()
    }

    static func topRated() -> Promise<[MovieModel]> {
        return moviesAPI.topRated()
    }

    func mapping(map: Map) {
        id <- map["id"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        releaseDate <- map["release_date"]
        title <- map["title"]
        voteAverage <- map["vote_average"]
    }

    func createFavorite(success: ((_ movieViewModel: MovieViewModel?) -> Void)? = nil, failure: (() -> Void)? = nil) {
        var favoriteEntity: FavoriteEntity?
        UIApplication.appDelegate.dataStack.perform(
            asynchronous: { [self] (transaction) -> Void in
                guard let id = id else { return }
                favoriteEntity = transaction.create(Into<FavoriteEntity>())
                favoriteEntity?.id = id
                favoriteEntity?.originalTitle = originalTitle
                favoriteEntity?.overview = overview
                favoriteEntity?.posterPath = posterPath
                favoriteEntity?.releaseDate = releaseDate
                favoriteEntity?.title = title
                if let voteAverage = voteAverage {
                    favoriteEntity?.voteAverage = voteAverage
                }
            },
            completion: { (result) -> Void in
                switch result {
                case .success:
                    guard let favoriteEntity = favoriteEntity else { return }
                    success?(MovieViewModel(movieModel: MovieModel(favoriteEntity: favoriteEntity)))
                case .failure (let error):
                    failure?()
                    print(error)
                }
            }
        )
    }

    func deleteFavorite(success: (() -> Void)? = nil, failure: (() -> Void)? = nil) {
        UIApplication.appDelegate.dataStack.perform(
            asynchronous: { [self] (transaction) -> Void in
                guard let id = id else { return }
                try transaction.deleteAll(From<FavoriteEntity>().where(\.id == id))
            },
            completion: { (result) -> Void in
                switch result {
                case .success:
                    success?()
                case .failure (let error):
                    failure?()
                    print(error)
                }
            }
        )

    }

}

