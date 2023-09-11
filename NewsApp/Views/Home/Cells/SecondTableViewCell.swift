//
//  SecondTableViewCell.swift
//  NewsApp
//
//  Created by Ecem Akçay on 11.09.2023.
//

import UIKit

class SecondTableViewCell: UITableViewCell {


    @IBOutlet weak var tableViewBox: TableViewBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableViewCellBox()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setupTableViewCellBox() {
            tableViewBox.frame = contentView.bounds
            contentView.addSubview(tableViewBox)

        }
}


