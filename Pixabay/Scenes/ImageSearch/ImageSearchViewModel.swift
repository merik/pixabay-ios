//
//  ImageSearchViewModel.swift
//  Pixabay
//
//  Created by Erik Mai on 20/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

enum ImageSearchResult {
    case success([PixabayImage])
    case error(String)
    case searching
    case notFound
}

class ImageSearchViewModel {
    
    private let page = 1        // Display first 50 photos
    private let perPage = 50    //
    
    var didFinishSearching: ((ImageSearchResult) -> Void)?
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func searchImages(with keyword: String) {
        
        didFinishSearching?(.searching)
        
        repository.searchImages(with: keyword, page: page, perPage: perPage, completion: {[weak self] result in
            switch result {
            case .success(let images):
                
                if images.isEmpty {
                    self?.didFinishSearching?(.notFound)
                    return
                }
                
                self?.didFinishSearching?(.success(images))
            case .failure(let error):
                self?.didFinishSearching?(.error(error.message))
            }
        })
    }
}
