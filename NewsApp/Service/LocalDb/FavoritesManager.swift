//
//  FavoritesManager.swift
//  NewsApp
//
//  Created by Ecem Akçay on 17.09.2023.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager() // Singleton oluşturuyoruz

    private init() {} // Singleton yapısı için private bir initializer

    private var favoriteArticles: [FavoriteModel] = []

    // Favori haberleri yükle
    func loadFavoriteNews() {
        if let newsData = UserDefaults.standard.data(forKey: "favoriteNews"),
           let favoriteArticles = try? JSONDecoder().decode([FavoriteModel].self, from: newsData) {
            self.favoriteArticles = favoriteArticles
        }
    }

    // Bir haberi favorilere ekle veya kaldır
    func toggleFavoriteNews(_ article: FavoriteModel) {
        if let index = favoriteArticles.firstIndex(where: { $0.title == article.title }) {
            // Haber favorilerde zaten varsa, kaldır
            favoriteArticles.remove(at: index)
        } else {
            // Haber favorilerde yoksa, ekle
            favoriteArticles.append(article)
        }

        // Favori haberleri UserDefaults ile sakla
        if let newsData = try? JSONEncoder().encode(favoriteArticles) {
            UserDefaults.standard.set(newsData, forKey: "favoriteNews")
        }
    }

    // Favori haberleri getir
    func getFavoriteNews() -> [FavoriteModel] {
        return favoriteArticles
    }
}
