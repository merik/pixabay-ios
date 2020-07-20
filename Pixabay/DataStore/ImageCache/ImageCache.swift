//
//  ImageCache.swift
//  Pixabay
//
//  Created by Erik Mai on 21/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

protocol ImageCache {
    func image(for url: String) -> UIImage?
    func insertImage(_ image: UIImage?, for url: String)
    func removeImage(for url: String)
    func removeAllImages()
}
