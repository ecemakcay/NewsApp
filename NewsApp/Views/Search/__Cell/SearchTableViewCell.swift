//
//  SearchTableViewCell.swift
//  NewsApp
//
//  Created by Ecem Akçay on 19.09.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

  
    @IBOutlet weak var tableViewBox: TableViewBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableViewCellBox()
    }

    func configure(with article: Article) {
           tableViewBox.configure(with: article)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    private func setupTableViewCellBox() {
            tableViewBox.frame = contentView.bounds
            contentView.addSubview(tableViewBox)

    }

}
