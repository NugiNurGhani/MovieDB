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
                        DispatchQueue.main.async {
                            print("movieName: \(dataObject.title)")
                        }
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
}
