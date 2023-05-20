//
//  Product.swift
//  IOS
//
//  Created by Jessie van Nuenen on 08/05/2023.
//

import Foundation

struct ProductResponse: Decodable {
    let code: String
    let product: ProductInfo?
}

struct ProductInfo: Decodable, Identifiable {
    let _id: String
    let product_name: String
    let ingredients: [Ingredient]?
    let ingredients_text: String?
    let ingredients_analysis_tags: [String]?
    let image_url: String?
    let description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    let origin: String?
    let manufacturing_places: String?
    let energy_value: String?
    let nutriments: Nutriments?
    
    
    var id: String {
            return _id
        }
    
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

struct Ingredient: Decodable, Identifiable {
    let id: String
    let text: String
    let vegan: String?
    let vegetarian: String?
    let ingredients: [Ingredient]?
    
    var isUnknown: Bool {
        return vegan == "maybe"
    }
    
    var isVegan: Bool {
        if vegan != nil{
            return vegan == "yes"
        }
        return true
    }
    
    var isVegetarian: Bool {
        return vegetarian == "yes"
    }
}

struct Nutriments: Decodable {
    let vitamin_b12: Double?
    let iron: Double?
    let calcium: Double?
    let fibre: Double?
    let fat: Double?
    let sugars: Double?
    let carbohydrates: Double?
    let net_weight_value: Double?
}

func fetchProductByCode(code: String) async throws -> ProductInfo? {
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
