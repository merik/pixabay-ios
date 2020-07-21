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
    
    private struct CacheData {
        let image: UIImage
        let timestamp: TimeInterval
    }
    
    private var maxImages: Int
    private var cache: [String: CacheData]
    
    private let semaphore = DispatchSemaphore(value: 1)
    
    init(maxImages: Int = 100) {
        self.maxImages = maxImages
        self.cache = [:]
    }
    
    func image(for url: String) -> UIImage? {
        semaphore.wait()
        defer {
            semaphore.signal()
        }
        return cache[url]?.image
    }
    
    func insertImage(_ image: UIImage?, for url: String) {
        
        guard let image = image else {
            return
        }
        
        semaphore.wait()
        defer {
            semaphore.signal()
        }
        
        removeOldCacheIfNecessory()
        cache[url] = CacheData(image: image, timestamp: Date().timeIntervalSince1970)
        
    }
    
    private func removeOldCacheIfNecessory() {
        if cache.count >= maxImages {
            if let item = cache.min(by: {(item1, item2) in
                return item1.value.timestamp < item2.value.timestamp
            }) {
                cache.removeValue(forKey: item.key)
            }
        }
    }
    
    func removeImage(for url: String) {
        defer {
            semaphore.signal()
        }
        cache.removeValue(forKey: url)
    }
    
    func removeAllImages() {
        defer {
            semaphore.signal()
        }
        cache.removeAll()
    }
    
    
}
