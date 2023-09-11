//
//  HomeTableViewCell.swift
//  NewsApp
//
//  Created by Ecem Akçay on 10.09.2023.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        prepareCollectionView()
        
        

        let design = UICollectionViewFlowLayout()
        design.scrollDirection = .horizontal
        collectionView.collectionViewLayout = design
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }

}
extension FirstTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
       
        return cell
    }

    
    
}