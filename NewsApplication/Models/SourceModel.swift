//
//  SourceModel.swift
//  NewsApplication
//
//  Created by Nimap on 24/02/24.
//

import UIKit

class SourceModel: NSObject {
    var id: String?
    var name: String?

    init(dictionary: [String : Any]) {
        super.init()
        id = dictionary["id"] as? String
        name = dictionary["name"] as? String
    }
}
