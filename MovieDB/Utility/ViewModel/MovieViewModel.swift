//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 19/10/20.
//

import Foundation

class MovieViewModel {
    
    var repository: MovieReq?
    init() {
        repository = MovieReq()
    }
    
    var dataMovie: [DetailModel] = []
    var popularMovie: [DiscoverResult] = []
    var comingSoonMovie: [DiscoverResult] = []
    var topRatedMovie: [TopRatedResult] = []
    
    func getDetail(params: String) {
        guard let repo = repository else { return }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            repo.getMovieDetail(idMovie: params) { result, error in
                if error != nil {
                }else{
                    guard let data = result else { return }
                    do {
                        let dataObject = try JSONDecoder().decode(DetailModel.self, from: data)
                        self.dataMovie.append(dataObject)
//                        DispatchQueue.main.async {
//                            print("movieName: \(dataObject.title)")
//                        }
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
    
    func getPopularMovies() {
        guard let repo = repository else { return }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            repo.getPopular(completion: { result, error in
                if error != nil {
                }else{
                    guard let data = result else { return }
                    do {
                        let dataObject = try JSONDecoder().decode(DiscoverModel.self, from: data)
                        self.popularMovie.append(contentsOf: dataObject.results)
//                        DispatchQueue.main.async {
//                            print("movieName: \(self.popularMovie)")
//                        }
                    }catch{
                        print(error)
                    }
                }
            })
        }
    }
    
    func getComingSoonMovies() {
        guard let repo = repository else { return }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            repo.getComingSoon(completion: { result, error in
                if error != nil {
                }else{
                    guard let data = result else { return }
                    do {
                        let dataObject = try JSONDecoder().decode(DiscoverModel.self, from: data)
                        self.comingSoonMovie.append(contentsOf: dataObject.results)
//                        DispatchQueue.main.async {
//                            print("movieName: \(self.popularMovie)")
//                        }
                    }catch{
                        print(error)
                    }
                }
            })
        }
    }
    
    func getTopRatedMovies() {
        guard let repo = repository else { return }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            repo.getTopRated(completion: { result, error in
                if error != nil {
                }else{
                    guard let data = result else { return }
                    do {
                        let dataObject = try JSONDecoder().decode(TopRatedModel.self, from: data)
                        self.topRatedMovie.append(contentsOf: dataObject.results)
//                        DispatchQueue.main.async {
//                            print("movieName: \(self.popularMovie)")
//                        }
                    }catch{
                        print(error)
                    }
                }
            })
        }
    }
}
