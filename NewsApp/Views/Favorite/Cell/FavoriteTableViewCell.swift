//
//  FavoriteTableViewCell.swift
//  NewsApp
//
//  Created by Ecem Akçay on 17.09.2023.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteTableViewBox: TableViewBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableViewCellBox()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with article: Article) {
        favoriteTableViewBox.configure(with: article)
    }
    
    private func setupTableViewCellBox() {
        favoriteTableViewBox.frame = contentView.bounds
            contentView.addSubview(favoriteTableViewBox)

    }
}
