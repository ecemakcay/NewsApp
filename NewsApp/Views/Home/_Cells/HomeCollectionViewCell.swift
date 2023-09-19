//
//  HomeCollectionViewCell.swift
//  NewsApp
//
//  Created by Ecem Akçay on 11.09.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionViewBox: CollectionViewBox!

    
       func configure(with article: Article) {
           collectionViewBox.configure(with: article)
       }
       
       override func awakeFromNib() {
            super.awakeFromNib()
            setupCollectionViewBox()
        }

        private func setupCollectionViewBox() {
            collectionViewBox.frame = contentView.bounds
        }
}

 






