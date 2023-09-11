//
//  TableViewCellbox.swift
//  NewsApp
//
//  Created by Ecem Akçay on 11.09.2023.
//

import UIKit

class TableViewCellBox: UIView{
    
    @IBOutlet weak var tableViewCategoryLabel: UILabel!
    @IBOutlet weak var tableViewTitleLabel: UILabel!
    @IBOutlet weak var tableViewBoxImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        if let viewForXib = Bundle.main.loadNibNamed("TableViewCellBox", owner: self)?[0] as? UIView {
            viewForXib.frame = self.bounds
            viewForXib.layer.cornerRadius = 20
            addSubview(viewForXib)
        }
    }
}
