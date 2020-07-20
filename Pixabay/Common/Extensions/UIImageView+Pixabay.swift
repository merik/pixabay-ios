//
//  UIImageView+Pixabay.swift
//  Pixabay
//
//  Created by Erik Mai on 21/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(at url: String) {
        UIImageLoader.shared.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.shared.cancel(for: self)
    }
}
