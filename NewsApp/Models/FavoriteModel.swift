//
//  FavoriteModel.swift
//  NewsApp
//
//  Created by Ecem Akçay on 18.09.2023.
//

import Foundation

struct FavoriteModel: Codable {
    
    var title: String
    var urlToImage: String?

    init(title: String, urlToImage: String? = nil) {
        self.title = title
        self.urlToImage = urlToImage
    }
}
