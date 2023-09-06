//
//  OnboardingCollectionViewCell.swift
//  NewsApp
//
//  Created by Ecem Akçay on 6.09.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideImageView: UIImageView!
    
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = UIImage(named: slide.image )
        slideTitleLabel.text = slide.title
      }
}
