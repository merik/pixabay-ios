//
//  ImagesTableViewCell.swift
//  Pixabay
//
//  Created by Erik Mai on 20/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class ImagesTableViewCell: UITableViewCell {
    
    static let reuseIdentifierString = "ImagesTableViewCell"
    let defaultImageColorCode: UInt64 = 0xc6c6c8
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    private var pixabayImage: PixabayImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellImage.clipsToBounds = true
        cellImage.layer.cornerRadius = 5
        
    }
    
    override func prepareForReuse() {
        cellImage.cancelImageLoad()
        cellImage.image = nil
        
    }
    
    private var defaultImage: UIImage? {
        return UIImage.imageFromColor(UIColor(hexRGBValue: defaultImageColorCode))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImage(_ image: PixabayImage) {
        self.pixabayImage = image
        userLabel.text = image.user
        tagsLabel.text = image.tags
        
        DispatchQueue.main.async {
            self.cellImage.image = self.defaultImage
        }
        
        cellImage.loadImage(at: image.url)
    }
    
}
