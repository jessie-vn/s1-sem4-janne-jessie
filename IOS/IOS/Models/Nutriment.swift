//
//  Ingredient.swift
//  IOS
//
//  Created by Janne van Seggelen on 15/05/2023.
//

import Foundation

class Nutriment: Identifiable {
    var title: String
    var value: String
    var dailyNeed: String
    var weightProcentage: String
    
    init(title: String, value: String, dailyNeed: String) {
        self.title = title
        self.value = value
        self.dailyNeed = dailyNeed
        self.weightProcentage = "-"
    }
    init(title: String, value: String) {
        self.title = title
        self.value = value
        self.dailyNeed = "-"
        self.weightProcentage = "-"
    }
    
    init(title: String, value: String, weightProcentage: String) {
        self.title = title
        self.value = value
        self.dailyNeed = "-"
        self.weightProcentage = weightProcentage
    }
    init(title: String, value: String, dailyNeed: String, weightProcentage: String) {
        self.title = title
        self.value = value
        self.dailyNeed = dailyNeed
        self.weightProcentage = weightProcentage
    }
}
