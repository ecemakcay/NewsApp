//
//  CollectionViewBox.swift
//  NewsApp
//
//  Created by Ecem Akçay on 11.09.2023.
//

import UIKit

class CollectionViewBox: UIView {
   
    @IBOutlet weak var collectionViewImage: UIImageView!
    @IBOutlet weak var collectionViewTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        if let viewForXib = Bundle.main.loadNibNamed("CollectionViewBox", owner: self)?[0] as? UIView {
            viewForXib.frame = self.bounds
            viewForXib.layer.cornerRadius = 20
            addSubview(viewForXib)
        }
    }
    
    func configure(with article: Article) {
        collectionViewTitle.text = article.title
        loadImage(from: article.urlToImage)
        
    }
    
    private func loadImage(from urlString: String?) {
            guard let urlString = urlString, let url = URL(string: urlString) else {
                // URL geçersiz veya boş
                return
            }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    // Resim alınamadı
                    return
                }
                
                // Resmi ana thread üzerinde güncelle
                DispatchQueue.main.async {
                    self?.collectionViewImage.image = image
                }
            }.resume()
        }
}
