//
//  Article.swift
//  NewsApp
//
//  Created by Ecem Akçay on 13.09.2023.
//

import Foundation

struct Article: Codable {
    
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var author: String?
    
    
    init(title: String, description: String?, url: String, urlToImage: String? = nil, publishedAt: String, author: String?) {
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.author = author
    }
    
    init() {
          self.title = ""
          self.description = ""
          self.url = ""
          self.urlToImage = ""
          self.publishedAt = ""
          self.author = ""
      }
    
}

