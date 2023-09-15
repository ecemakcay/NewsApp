//
//  HomeTableViewCell.swift
//  NewsApp
//
//  Created by Ecem Akçay on 10.09.2023.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var articles: [Article] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareCollectionView()

        let design = UICollectionViewFlowLayout()
        design.scrollDirection = .horizontal
        collectionView.collectionViewLayout = design
    }

    func configure(with article: [Article]) {
        collectionView.reloadData()
    }

    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
}

extension FirstTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell

        let article = articles[indexPath.item]
        cell.configure(with: article)

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 296, height: 279)
        }
    
}
