//
//  APICall.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import Foundation

struct API {
    static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
}

protocol EndPoint {
    var url: String { get }
    
}

enum Endpoints {
    enum Gets: EndPoint {
        case categories
        case meal
        case meals
        case search
        
        
        public var url: String {
            switch self {
            case .categories:
                return "\(API.baseUrl)categories.php"
            case .meal:
                return "\(API.baseUrl)lookup.php?i="
            case .meals:
                return "\(API.baseUrl)filter.php?c="
            case .search:
                return "\(API.baseUrl)search.php?s="
            }
        }
        
        
    }
}
