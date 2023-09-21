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
        design.sectionInset = UIEdgeInsets(top: 50, left: 15, bottom: 60, right: 15)
        collectionView.collectionViewLayout = design
    }

    func configure(with article: [Article]) {
        self.articles = article
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailPageVC", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailPageVC") as? DetailPageVC {
            detailVC.article = articles[indexPath.row]
            if let navigationController = findNavigationController() {
                navigationController.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 366, height: 228)
        }
    
    private func findNavigationController() -> UINavigationController? {
        var responder: UIResponder? = self
        while let currentResponder = responder {
            if let navigationController = currentResponder as? UINavigationController {
                return navigationController
            }
            responder = currentResponder.next
        }
        return nil
    }
}
