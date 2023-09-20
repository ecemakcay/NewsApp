//
//  DetailViewModel.swift
//  NewsApp
//
//  Created by Ecem Akçay on 20.09.2023.
//

import Foundation

class DetailViewModel{
    
     func saveBtnAct(article: Article?) {
        if let article = article {
            FavoritesManager.shared.toggleFavoriteNews(article)
            
            if FavoritesManager.shared.getFavoriteNews().contains(where: { $0.title == article.title }) {
                print("News added to favorites.")
            } else {
                print("News removed to favorites.")
            }
        }
    }
}
