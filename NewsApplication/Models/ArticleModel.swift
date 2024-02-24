//
//  Article.swift
//  NewsApplication
//
//  Created by Nimap on 24/02/24.
//

import UIKit

class ArticleModel: NSObject {
    var source: SourceModel?
    var author: String?
    var title: String?
    var descriptions: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    init(dictionary: [String : Any]) {
        super.init()
        source = dictionary["source"] as? SourceModel
        author = dictionary["author"] as? String
        title = dictionary["title"] as? String
        descriptions = dictionary["description"] as? String
        url = dictionary["url"] as? String
        urlToImage = dictionary["urlToImage"] as? String
        publishedAt = dictionary["publishedAt"] as? String
        content = dictionary["content"] as? String
    }
    
}
