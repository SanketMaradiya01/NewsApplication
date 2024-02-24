//
//  API.swift
//  NewsApplication
//
//  Created by Nimap on 24/02/24.
//

import UIKit

class APIModel: NSObject {
    var Status: String?
    var TotalResult: Int?
    var Article: [ArticleModel]?
    
    init(dictionary: [String : Any]) {
        super.init()
        Status = dictionary["status"] as? String
        TotalResult = dictionary["totalResults"] as? Int
        Article = dictionary["articles"] as? [ArticleModel]
    }
}

