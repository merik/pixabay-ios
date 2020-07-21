//
//  Repository.swift
//  Pixabay
//
//  Created by Erik Mai on 20/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import Foundation

struct PixabayError: Error {
    let message: String
}

protocol Repository {
    func searchImages(with keyword: String, page: Int, perPage: Int, completion: @escaping(Result<[PixabayImage], PixabayError>) -> Void)
}
