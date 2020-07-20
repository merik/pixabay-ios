//
//  InMemoryImageCache.swift
//  Pixabay
//
//  Created by Erik Mai on 21/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit
import Foundation

class InMemoryImageCache: ImageCache {
    
    private var maxImages: Int
    private var cache: [String: UIImage]
    
    private let semaphore = DispatchSemaphore(value: 1)
    
    init(maxImages: Int = 100) {
        self.maxImages = maxImages
        self.cache = [:]
    }
    
    func image(for url: String) -> UIImage? {
        return cache[url]
    }
    
    func insertImage(_ image: UIImage?, for url: String) {
        semaphore.wait()
        defer {
            semaphore.signal()
        }
        // TODO: enforce maxImages
        
        cache[url] = image
        
    }
    
    func removeImage(for url: String) {
        cache.removeValue(forKey: url)
    }
    
    func removeAllImages() {
        cache.removeAll()
    }
    
    
}
