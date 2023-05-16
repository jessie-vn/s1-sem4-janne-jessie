//
//  DetailsView.swift
//  IOS
//
//  Created by Janne van Seggelen on 08/05/2023.
//

import SwiftUI

struct DetailsView: View {
    var product: Product
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var hovered = 0
    var ingredients: [Ingredient] = [
        Ingredient(title: "Energy", value: "435 KJ (102 kcal)"),
        Ingredient(title: "Sugar", value: "22,5 g", weightProcentage: "3%"),
        Ingredient(title: "Colaries", value: "45,3 g"),
        Ingredient(title: "Fat", value: "0.1 g", weightProcentage: "33%"),
        Ingredient(title: "High proteins", value: "No"),
        Ingredient(title: "Vitamines", value: "B12", dailyNeed: "57%"),
        Ingredient(title: "Vitamines", value: "B2", dailyNeed: "32%")
    ] // Hardcoded for now
    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                    Image(product.image)
                        .resizable()
                        .frame(width: 375, height: 375)
                        .padding(.bottom, 30)
                    
                    //Divider()
                    
                    Text(product.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                        .font(.system(size: 25))
                    Text(product.code)
                        .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                        .font(.system(size: 15))
                        .padding(.bottom, 5)
                    
                    HStack {
                        if (product.vegan) {
                            Image("vegan-yes")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("This product is vegan")
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.006, green: 0.498, blue: -0.002))
                        }
                        else {
                            Image("vegan-no")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text("This product is not vegan")
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 0.88, green: 0.271, blue: 0.273))
                        }
                    }
                    .padding(.bottom, 10)
                
                //MARK: Hardcoded so its easier to combine our products objects
                    
                    Text("Product backstory")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                    Text(product.description)
                        .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                        .multilineTextAlignment(.center)
                        .padding()
                
                Text("Ingredient list")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                Text("Tomaten (148 g per 100g tomato ketchup), azijn, suiker, zout, specerij- en kruidextracten (bevatten SELDERIJ), specerij")
                    .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack {
                    Text("Nutritional values")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                        .padding()
                    Spacer()
                    Button("Toggle") {
                        hovered += 1
                        if hovered > 2 {
                            hovered = 0
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding()
                }
                Table(ingredients) {
                    TableColumn("Ingredients") { ingredient in
                        HStack {
                            if hovered == 1 {
                                Text(ingredient.title)
                                Spacer()
                                if sizeClass == .compact {
                                    Text(ingredient.dailyNeed)
                                        .font(.caption2)
                                        .textCase(.uppercase)
                                }
                            }
                            else if hovered == 0 {
                                Text(ingredient.title)
                                Spacer()
                                if sizeClass == .compact {
                                    Text(ingredient.value)
                                        .font(.caption2)
                                        .textCase(.uppercase)
                                }
                            }
                            else {
                                Text(ingredient.title)
                                Spacer()
                                if sizeClass == .compact {
                                    Text(ingredient.weightProcentage)
                                        .font(.caption2)
                                        .textCase(.uppercase)
                                }
                            }
                        }
                    }
                    TableColumn("Each 100g", value: \.value)
                    TableColumn("Daily need (%)", value: \.dailyNeed)
                        .width(50)
                    TableColumn("Weight procentage (%)", value: \.weightProcentage)
                        .width(50)
                }
                .frame(width: 400, height: 500)
            }
            .padding()
        }
        .background(.white)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailsView(
                product: Product(image: "AH-Appelstroop", title: "title", vegan: false, description: "description", code: "1")
            )
        }
    }
}
