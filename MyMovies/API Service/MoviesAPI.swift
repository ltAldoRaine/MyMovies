//
//  MoviesAPI.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/20/20.
//

import Alamofire
import AlamofireObjectMapper
import PromiseKit

class MoviesAPI {

    func upcoming() -> Promise<[Movie]> {
        return Promise { seal in
            let url = "\(Network.moviesApirUrl)/movie/upcoming?api_key=\(Network.moviesApiKey)&language=en-US&page=1"
            AF.request(url, method: .get, encoding: JSONEncoding.default)
                .validate()
                .responseObject { (response: AFDataResponse<MoviesResponse>) -> Void in
                    switch response.result {
                    case .success(let value):
                        guard let data = value.results else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        seal.fulfill(data)
                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }

    func popular() -> Promise<[Movie]> {
        return Promise { seal in
            let url = "\(Network.moviesApirUrl)/movie/popular?api_key=\(Network.moviesApiKey)&language=en-US&page=1"
            AF.request(url, method: .get, encoding: JSONEncoding.default)
                .validate()
                .responseObject { (response: AFDataResponse<MoviesResponse>) -> Void in
                    switch response.result {
                    case .success(let value):
                        guard let data = value.results else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        seal.fulfill(data)
                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }

    func topRated() -> Promise<[Movie]> {
        return Promise { seal in
            let url = "\(Network.moviesApirUrl)/movie/top_rated?api_key=\(Network.moviesApiKey)&language=en-US&page=1"
            AF.request(url, method: .get, encoding: JSONEncoding.default)
                .validate()
                .responseObject { (response: AFDataResponse<MoviesResponse>) -> Void in
                    switch response.result {
                    case .success(let value):
                        guard let data = value.results else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        seal.fulfill(data)
                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }

}
