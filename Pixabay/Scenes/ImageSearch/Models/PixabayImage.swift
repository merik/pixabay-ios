//
//  PixabayImage.swift
//  Pixabay
//
//  Created by Erik Mai on 20/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

struct PixabayImage {
    let id: Int
    let pageUrl: String
    let previewUrl: String
    let webformatUrl: String
    let largeImageUrl: String
    let tags: String
    let user: String
    
    var url: String {
        return largeImageUrl
    }
}

extension PixabayImage: Decodable {
    
    enum PixabayImageCodingKeys: String, CodingKey {
        case id
        case pageUrl = "pageURL"
        case previewUrl = "previewURL"
        case webformatUrl = "webformatURL"
        case largeImageUrl = "largeImageURL"
        case tags
        case user
    }
    
    init(from decoder: Decoder) throws {
        
        let imageContainer = try decoder.container(keyedBy: PixabayImageCodingKeys.self)
        
        id = try imageContainer.decode(Int.self, forKey: .id)
        pageUrl = try imageContainer.decode(String.self, forKey: .pageUrl)
        previewUrl = try imageContainer.decode(String.self, forKey: .previewUrl)
        webformatUrl = try imageContainer.decode(String.self, forKey: .webformatUrl)
        largeImageUrl = try imageContainer.decode(String.self, forKey: .largeImageUrl)
        tags = try imageContainer.decode(String.self, forKey: .tags)
        user = try imageContainer.decode(String.self, forKey: .user)
        
    }
}

struct PixabayImageApiResponse {
    let images: [PixabayImage]
}

extension PixabayImageApiResponse: Decodable {
    private enum PixabayImageApiResponseCodingKeys: String, CodingKey {
        case images = "hits"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PixabayImageApiResponseCodingKeys.self)
        images = try container.decode([PixabayImage].self, forKey: .images)
    }
}
