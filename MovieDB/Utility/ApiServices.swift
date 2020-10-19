//
//  ApiServices.swift
//  MovieDB
//
//  Created by Nugi Nuryanto G on 19/10/20.
//

import Foundation
import Alamofire

struct ErrorRequestModel : Codable {
    let errorCode: Int?
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "status"
        case message = "message"
    }
    
    
}

class ApiService: Any {
    let baseApiUrl = K.baseURL
    func get(_ url: String, parameters: Parameters? = nil, completion: @escaping (Data?, Error?) -> Void) {
        AF.request(url,method: .get, parameters: parameters).validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    completion(value, nil)
                case .failure(let error):
                    if let statusCode = response.response?.statusCode, let data = response.data {
                        #if DEBUG
                        debugPrint("ERROR STATUS CODE \(statusCode) of \(url)")
                        #endif
                        
                        if statusCode == 429 {
                            completion(nil, error)
                            return
                        }
                        
                        do {
                            let decodedData = try JSONDecoder().decode(ErrorRequestModel.self, from: data)
                            completion(nil, NSError(domain: "", code: statusCode, userInfo: [
                                NSLocalizedDescriptionKey:  self.getErrMessage(msg: decodedData.message)
                            ]))
                        } catch {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, error)
                    }
                }
            }
    }
    
    func getErrMessage(msg: String) -> String {
        return msg
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}

