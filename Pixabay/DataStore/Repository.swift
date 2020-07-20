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
    // TODO: enforce max images = 50
    func searchImages(with keyword: String, completion: @escaping(Result<[PixabayImage], PixabayError>) -> Void)
}
