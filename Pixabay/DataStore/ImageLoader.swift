//
//  ImageLoader.swift
//  Pixabay
//
//  Created by Erik Mai on 21/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {
    private let imageCache: ImageCache?
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    init(cache: ImageCache?) {
        self.imageCache = cache
    }
    
    func loadImage(_ urlString: String, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        if let image = imageCache?.image(for: urlString) {
            completion(.success(image))
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return nil
        }
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            defer {
                self.runningRequests.removeValue(forKey: uuid)
            }
            
            if let data = data, let image = UIImage(data: data) {
                self.imageCache?.insertImage(image, for: urlString)
                completion(.success(image))
                return
            }
            
            guard let error = error else {
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}
