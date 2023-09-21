//
//  UIView+Extension.swift
//  NewsApp
//
//  Created by Ecem Akçay on 7.09.2023.
//

import Foundation
import UIKit

extension UIView {
    
    func addBackground() {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "space")
        imageViewBackground.alpha = 0.4
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
        
    }
    
}
