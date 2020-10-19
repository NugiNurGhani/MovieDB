//
//  Constant.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 17/10/20.
//

import Foundation

struct K {
    static let baseURL    = "https://api.themoviedb.org/3/"
    static let imgURL     = "https://image.tmdb.org/t/p/w500/"
    static let detail     = "movie/"
    static let discover   = "discover/movie"
    static let language   = "&language=en-US"
    static let popular    = "&sort_by=popularity.desc"
    static let filter     = "&include_adult=false&include_video=false&page=1"
    static let comingSoon = "&year=2021"
    static let topRated   = "top_rated"
    static let apiKey     = "?api_key=747d6927fbc3c4b6fce72da3a3762fcc"
}
