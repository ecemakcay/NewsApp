//
//  SearchViewModel.swift
//  NewsApp
//
//  Created by Ecem Akçay on 19.09.2023.
//

import Foundation

class SearchViewModel {
    
    let request = NetworkRequest()

    func getSearch(query: String?){
        request.fetchEverything(query: query)
    }
}
