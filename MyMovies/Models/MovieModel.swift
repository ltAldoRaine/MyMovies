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

    static func favorite() -> Promise<[MovieModel]> {
        return Promise { seal in
            do {
                let data = try UIApplication.appDelegate.dataStack.fetchAll(From<FavoriteEntity>().orderBy(.descending(\.createdAt)))
                    .map { MovieModel(favoriteEntity: $0) }
                seal.fulfill(data)
            }
            catch (let error) {
                seal.reject(error)
            }
        }
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

    func createFavorite() -> Promise<MovieModel> {
        return Promise { seal in
            var favoriteEntity: FavoriteEntity?
            UIApplication.appDelegate.dataStack.perform(
                asynchronous: { [self] (transaction) -> Void in
                    guard let id = id else {
                        try transaction.cancel()
                    }
                    favoriteEntity = transaction.create(Into<FavoriteEntity>())
                    favoriteEntity?.id = id
                    favoriteEntity?.originalTitle = originalTitle
                    favoriteEntity?.overview = overview
                    favoriteEntity?.posterPath = posterPath
                    favoriteEntity?.releaseDate = releaseDate
                    favoriteEntity?.title = title
                    favoriteEntity?.createdAt = Date()
                    if let voteAverage = voteAverage {
                        favoriteEntity?.voteAverage = voteAverage
                    }
                },
                completion: { (result) -> Void in
                    switch result {
                    case .success:
                        guard let favoriteEntity = favoriteEntity else {
                            return seal.reject(DataError.unexpectedNiL)
                        }
                        seal.fulfill(MovieModel(favoriteEntity: favoriteEntity))
                    case .failure (let error):
                        seal.reject(error)
                    }
                }
            )
        }
    }

    func deleteFavorite() -> Promise<Void> {
        return Promise { seal in
            UIApplication.appDelegate.dataStack.perform(
                asynchronous: { [self] (transaction) -> Void in
                    do {
                        guard let id = id else {
                            throw DataError.unexpectedNiL
                        }
                        try transaction.deleteAll(From<FavoriteEntity>().where(\.id == id))
                    } catch _ {
                        try transaction.cancel()
                    }
                },
                completion: { (result) -> Void in
                    switch result {
                    case .success:
                        seal.fulfill_()
                    case .failure (let error):
                        seal.reject(error)
                    }
                }
            )
        }
    }

}

