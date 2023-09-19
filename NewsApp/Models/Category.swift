//
//  Category.swift
//  NewsApp
//
//  Created by Ecem Akçay on 18.09.2023.
//

import Foundation

enum Group: CaseIterable {
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
    case general
    
    var group: String {
        switch self {
        case .general:
            return "General"
        case .business:
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
            
        }
    }
}
