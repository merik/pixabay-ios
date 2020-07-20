//
//  UISearchBar+Pixabay.swift
//  Pixabay
//
//  Created by Erik Mai on 21/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func changePromptFont(_ font : UIFont?) {
        for containerView : UIView in (self.subviews[0]).subviews {
            for view in containerView.subviews {
                if let label = view as? UILabel {
                    label.font = font
                }
            }
        }
    }
    
}
