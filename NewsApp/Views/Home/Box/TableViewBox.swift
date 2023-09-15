//
//  TableViewBox.swift
//  NewsApp
//
//  Created by Ecem Akçay on 11.09.2023.
//

import UIKit

class TableViewBox: UIView{
    
    @IBOutlet weak var tableViewBoxTitle: UILabel!
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
        if let viewForXib = Bundle.main.loadNibNamed("TableViewBox", owner: self)?[0] as? UIView {
            viewForXib.frame = self.bounds
            viewForXib.layer.cornerRadius = 20
            addSubview(viewForXib)
        }
    }
    
    func configure(with article: Article) {
        tableViewBoxTitle.text = article.title
        loadImage(from: article.urlToImage)
        self.frame = CGRect(x: 0, y: 0, width: 355, height: 130)
    }
    
    private func loadImage(from urlString: String?) {
            guard let urlString = urlString, let url = URL(string: urlString) else {
                // URL geçersiz veya boş
                return
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    return
                }
                
                // Resmi ana thread üzerinde güncelle
                DispatchQueue.main.async {
                    self?.tableViewBoxImage.image = image
                }
            }.resume()
        }
}

