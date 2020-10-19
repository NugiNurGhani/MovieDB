//
//  MovieReq.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 19/10/20.
//

import Foundation
class MovieReq: ApiService {
    static let shared = MovieReq()
    
    func getPopular(completion: @escaping (Data?, Error?) -> Void) {
        let url = baseApiUrl+K.discover+K.apiKey+K.language+K.popular+K.filter
        get(url) { (result, error) in
            completion(result, error)
        }
    }
    
    func getComingSoon(completion: @escaping (Data?, Error?) -> Void) {
        let url = baseApiUrl+K.discover+K.apiKey+K.language+K.popular+K.filter+K.comingSoon
        get(url) { (result, error) in
            completion(result, error)
        } 
    }
    
    func getTopRated(completion: @escaping (Data?, Error?) -> Void) {
        let url = baseApiUrl+K.detail+K.topRated+K.apiKey+K.language+K.popular+K.filter
        get(url) { (result, error) in
            completion(result, error)
        }
    }
    
    func getMovieDetail(idMovie: String, completion: @escaping (Data?, Error?) -> Void) {
        let url = baseApiUrl+K.detail+"\(idMovie)"+K.apiKey+K.language
        get(url) { (result, error) in
            completion(result, error)
        }
    }
}
