//
//  FavoriteViewModel.swift
//  NewsApp
//
//  Created by Ecem Akçay on 21.09.2023.
//

import Foundation

class FavoriteViewModel{
    let manager = FavoritesManager.shared
    
    func delete(_ article: Article){
        manager.deleteFavorite(article)
    }
    func getFavoriteNews() -> [Article] {
        return manager.getFavoriteNews()
    }
    
}
