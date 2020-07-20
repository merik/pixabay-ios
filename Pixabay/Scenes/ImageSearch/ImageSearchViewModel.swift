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
    var didFinishSearching: ((ImageSearchResult) -> Void)?
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func searchImages(with keyword: String) {
        
        didFinishSearching?(.searching)
        
        repository.searchImages(with: keyword, completion: {[weak self] result in
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
