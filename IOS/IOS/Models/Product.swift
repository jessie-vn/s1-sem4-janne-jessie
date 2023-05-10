//
//  Product.swift
//  IOS
//
//  Created by Jessie van Nuenen on 08/05/2023.
//

import Foundation

struct ProductResponse: Decodable {
    let code: String
    let product: Product
}

struct Product: Decodable {
    let _id: String
    let product_name: String
    let ingredients: [Ingredient]?
    let ingredients_analysis_tags: [String]?
    
    var isUnknown: Bool {
        if let tags = ingredients_analysis_tags, tags.contains("en:vegan") || tags.contains("en:non-vegan") {
            return false
        }
        return true
    }
    
    //TODO: Add different ways to check
    var isVegan: Bool {
        if !isUnknown, let tags = ingredients_analysis_tags, tags.contains("en:vegan") {
            return true
        }
        return false
    }
}


struct Ingredient: Decodable {
    let id: String
    let text: String
    let vegan: String?
    let vegetarian: String?
    let ingredients: [Ingredient]?
    
    var isVegan: Bool {
        return vegan == "yes"
    }
    
    var isVegetarian: Bool {
        return vegetarian == "yes"
    }
}

func fetchProductByCode(code: String) async throws -> Product? {
    let url = URL(string: "https://world.openfoodfacts.org/api/v2/product/\(code)")
    
    if(url != nil){
        var request = URLRequest(url: url!)
        request.addValue("VegiScan - iOS - Version 1.0", forHTTPHeaderField: "User-Agent")
        
        print("URL request made successfully")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        //TODO: Handle different errors differently
        do {
            let decoded = try JSONDecoder().decode(ProductResponse.self, from: data)
            return decoded.product
        } catch {
            print("Error decoding product data: \(error)")
            return nil
        }
    }
    return nil
}
