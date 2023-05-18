//
//  DetailsView.swift
//  IOS
//
//  Created by Janne van Seggelen on 08/05/2023.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var hovered = 0
    var nutriments: [Nutriment] = [
        Nutriment(title: "Energy", value: "435 KJ (102 kcal)"),
        Nutriment(title: "Sugar", value: "22,5 g", weightProcentage: "3%"),
        Nutriment(title: "Calories", value: "45,3 g"),
        Nutriment(title: "Fat", value: "0.1 g", weightProcentage: "33%"),
        Nutriment(title: "High proteins", value: "No"),
        Nutriment(title: "Vitamines", value: "B12", dailyNeed: "57%"),
        Nutriment(title: "Vitamines", value: "B2", dailyNeed: "32%")
    ] // Hardcoded for now
    var product: ProductInfo
    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                AsyncImage(url: URL(string: product.image_url!)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 400, height: 400)
                
                Text(product.product_name)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                    .font(.system(size: 25))
                Text(product._id)
                    .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                    .font(.system(size: 15))
                    .padding(.bottom, 5)
                
                HStack {
                    if (product.isVegan) {
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
                if (product.ingredients_text == nil) {
                    Text("Ingredients unknown")
                        .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                else{
                    Text(product.ingredients_text!)
                        .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
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
                Table(nutriments) {
                    TableColumn("Nutriments") { nutriment in
                        HStack {
                            if hovered == 1 {
                                Text(nutriment.title)
                                Spacer()
                                if sizeClass == .compact {
                                    Text(nutriment.dailyNeed)
                                        .font(.caption2)
                                        .textCase(.uppercase)
                                }
                            }
                            else if hovered == 0 {
                                Text(nutriment.title)
                                Spacer()
                                if sizeClass == .compact {
                                    Text(nutriment.value)
                                        .font(.caption2)
                                        .textCase(.uppercase)
                                }
                            }
                            else {
                                Text(nutriment.title)
                                Spacer()
                                if sizeClass == .compact {
                                    Text(nutriment.weightProcentage)
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
        DetailsView(
            product: ProductInfo(_id: "1", product_name: "title", ingredients: nil, ingredients_text: "Ingredients unknown",ingredients_analysis_tags: ["en:non-vegan"], image_url: "AH-Appelstroop", origin: "", manufacturing_places: "", energy_value: "", nutriments: nil)
        )
    }
}
