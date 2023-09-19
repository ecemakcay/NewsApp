//
//  NetworkRequest.swift
//  NewsApp
//
//  Created by Ecem Akçay on 19.09.2023.
//

import Foundation

class NetworkRequest{
    
    var topHeadlines: [Article] = []
    var everything: [Article] = []
    private let networkManager = NetworkManager.shared
    
    // Verilerin güncellenmesini izlemek için
    var onDataUpdate: (() -> Void)?
    
    
    func fetchTopHeadlines() {
        let endpoint = Endpoint.getTopHeadlines(sources:"bbc-news")
        networkManager.fetchData(from: endpoint, responseType: NewsResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.topHeadlines = response.articles
                self?.onDataUpdate?()
                print("Top Headlines alındı. Toplam \(response.articles.count) makale.")
            case .failure(let error):
                print("Topheadlines data error: \(error)")
            }
        }
    }
    
    func fetchEverything(query: String?) {
        let endpoint = Endpoint.getEverything(query: query)
        networkManager.fetchData(from: endpoint, responseType: NewsResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.everything = response.articles
                self?.onDataUpdate?()
            case .failure(let error):
                print("Everything data error: \(error)")
            }
        }
    }

}
