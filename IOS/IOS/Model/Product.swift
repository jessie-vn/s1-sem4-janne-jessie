//
//  Product.swift
//  IOS
//
//  Created by Janne van Seggelen on 08/05/2023.
//

import Foundation

class Product: Identifiable {
    var image: String
    var title: String
    var vegan: Bool
    var description: String
    var code: String
    
    init(image: String, title: String, vegan: Bool, description: String, code: String) {
        self.image = image
        self.title = title
        self.vegan = vegan
        self.description = description
        self.code = code
    }
}
