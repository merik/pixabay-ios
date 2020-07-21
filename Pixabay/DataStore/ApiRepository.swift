//
//  ApiRepository.swift
//  Pixabay
//
//  Created by Erik Mai on 20/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

class ApiRepository: Repository {
    
    func searchImages(with keyword: String, page: Int, perPage: Int, completion: @escaping (Result<[PixabayImage], PixabayError>) -> Void) {
        PixabayApiService.shared.searchData(with: .search, keyword: keyword, page: page, perPage: perPage, completion: {(data, error) in
            
            if let error = error {
                let errorMessage = (error as NSError).userInfo["errorMessage"] as? String ?? "Error Occurred"
                completion(.failure(PixabayError(message: errorMessage)))
                return
            }
            
            guard let data = data else {
                completion(.failure(PixabayError(message: "Invalid Data Response")))
                return
            }
            
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(PixabayImageApiResponse.self, from: data) else {
                completion(.failure(PixabayError(message: "Invalid Data Response")))
                return
            }
            
            completion(.success(response.images))
            
        })
    }
    
}

enum PixabayApiResources: String {
    case search = ""
}

struct PixabayApiService {
    
    let key = "17552368-013e63a193766bdd86b0a2dab"
    
    static let shared = PixabayApiService()
    
    private let urlSession = URLSession.shared
    
    private init() {
        
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pixabay.com"
        return components
    }
    
    func searchData(with resources: PixabayApiResources, keyword: String, page: Int, perPage: Int, completion: @escaping(Data?, Error?) -> Void) {
        
        fetch(with: resources, parameters: [
                "key": self.key,
                "image_type": "photo",
                "q": keyword,
                "page": "\(page)",
                "per_page": "\(perPage)"
        ], completion: completion)
    }
    
    private func fetch(with resources: PixabayApiResources, parameters: [String: String], completion: @escaping(Data?, Error?) -> Void) {
        
        var urlComponents = self.urlComponents
        urlComponents.path = "/api/\(resources.rawValue)"
        urlComponents.setQueryItems(with: parameters)
        
        guard let url = urlComponents.url else {
            completion(nil, NSError(domain: "", code: 100, userInfo: ["errorMessage": "Invalid Url"]))
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, NSError(domain: "", code: 100, userInfo: ["errorMessage": "Invalid Response"]))
                return
                
            }
                
            switch response.statusCode {
                case 200...299:
                    completion(data, error)
                
                // Error
                case 401...500: fallthrough
                case 501...599: fallthrough
                case 600: fallthrough
                default:
                    guard let data = data else {
                        completion(nil, NSError(domain: "", code: 100, userInfo: ["errorMessage": "Invalid Response"]))
                        return
                    }
                    
                    completion(data, NSError(domain: "", code: response.statusCode, userInfo: ["errorMessage": String(data: data, encoding: .utf8) as Any]))
                    
            }
           
        }.resume()
    }
    
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}

