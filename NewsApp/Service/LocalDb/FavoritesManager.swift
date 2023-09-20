//
//  FavoritesManager.swift
//  NewsApp
//
//  Created by Ecem Akçay on 17.09.2023.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    let favoriKey: String = "favoriteNews"

    private init() {}

    private var favoriteArticles: [Article] = []

    func loadFavoriteNews() {
        if let newsData = UserDefaults.standard.data(forKey: favoriKey) {
            do {
                let favoriteArticles = try JSONDecoder().decode([Article].self, from: newsData)
                self.favoriteArticles = favoriteArticles
                print("FAVORİTE ARTİCLES DECODED")
            } catch {
                print("DECODİNG ERROR: \(error)")
            }
        }
    }

    func toggleFavoriteNews(_ article: Article) {
        if let index = favoriteArticles.firstIndex(where: { $0.title == article.title }) {
            print("favoriden kaldırıldı")
            favoriteArticles.remove(at: index)
        } else {
            print("favoriye eklendi")
            favoriteArticles.append(article)
        }

        if let newsData = try? JSONEncoder().encode(favoriteArticles) {
            UserDefaults.standard.set(newsData, forKey: favoriKey)
        }
    }

    func getFavoriteNews() -> [Article] {
        return favoriteArticles
    }
}
