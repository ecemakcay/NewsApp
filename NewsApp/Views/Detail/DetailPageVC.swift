//
//  DetailPageVC.swift
//  NewsApp
//
//  Created by Ecem Akçay on 16.09.2023.
//

import UIKit

class DetailPageVC: UIViewController {
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var detailAuthorLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    var article: Article?
    var favoriteArticle: FavoriteModel?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveBtn.layer.cornerRadius = 10
        detailTitleLabel.layer.cornerRadius = 15
        
    
        if let article = article {
            detailAuthorLabel.text = "By \(article.author ?? "Unknow")"
            detailDescriptionLabel.text = article.description ?? ""
            detailTitleLabel.text = article.title
            
           
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                let session = URLSession.shared
                let task = session.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }

                    if let data = data {
                        DispatchQueue.main.async {
                            self.detailImageView.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }

        }
    }
    
    @IBAction func saveBtnAct(_ sender: Any) {
        print("detay buton tıklandı")
           if let favoriteArticle = favoriteArticle {
               FavoritesManager.shared.toggleFavoriteNews(favoriteArticle)
               
               if FavoritesManager.shared.getFavoriteNews().contains(where: { $0.title == favoriteArticle.title }) {
                  
                   print("Haber favorilere eklendi.")
               } else {
                   print("Haber favorilerden kaldırıldı.")
               }
           }
       }
}
