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
                
                ScrollView {
                    HStack {
//                        Text("Nutritional values")
//                            .fontWeight(.bold)
//                            .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
//                            .padding()
                        if hovered == 0 { Text("Values").foregroundColor(.black).padding() }
                        else if hovered == 1 { Text("Daily Need (%)").foregroundColor(.black).padding() }
                        else { Text("Weight Procentage (%)").foregroundColor(.black).padding() }
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
                    
                    Table(of: Nutriment.self) {
                        TableColumn("Nutriment") { nutriment in
                            HStack {
                                Text(nutriment.title)
                                Spacer()
                                if sizeClass == .compact {
                                    if hovered == 0 {
                                        Text(nutriment.value)
                                            .font(.caption2)
                                            .textCase(.uppercase)
                                    }
                                    else if hovered == 1 {
                                        Text(nutriment.dailyNeed)
                                            .font(.caption2)
                                            .textCase(.uppercase)
                                    }
                                    else {
                                        Text(nutriment.weightProcentage)
                                            .font(.caption2)
                                            .textCase(.uppercase)
                                    }
                                }
                            }
                        }
                        TableColumn("Value") { nutriment in
                            Text(nutriment.value)
                        }
                        TableColumn("Weight Procentage (%)") { nutriment in
                            Text(nutriment.weightProcentage)
                        }
                        TableColumn("Daily Need (%)") { nutriment in
                            Text(nutriment.dailyNeed)
                        }
                    } rows: {
                        if (product.nutriments?.vitamin_b12 != nil) {
                            TableRow(Nutriment(
                                title: "Vitimine B12",
                                value: String((product.nutriments?.vitamin_b12)!),
                                dailyNeed: String(round((((product.nutriments?.vitamin_b12)! / 5) * 100) * 10) / 10) + "%")) }
                        if (product.nutriments?.iron != nil) {
                            TableRow(Nutriment(
                                title: "Iron",
                                value: String((product.nutriments?.iron)!),
                                dailyNeed: String(round((((product.nutriments?.iron)! / 18) * 100) * 10) / 10) + "%")) }
                        if (product.nutriments?.calcium != nil) {
                            TableRow(Nutriment(
                                title: "Calcium",
                                value: String((product.nutriments?.calcium)!),
                                dailyNeed: String(round((((product.nutriments?.calcium)! / 1) * 100) * 10) / 10) + "%")) }
                        if (product.nutriments?.fibre != nil) {
                            TableRow(Nutriment(
                                title: "Fibre",
                                value: String((product.nutriments?.fibre)!),
                                dailyNeed: String(round((((product.nutriments?.fibre)! / 40) * 100) * 10) / 10) + "%")) }
                        if (product.nutriments?.fat != nil) {
                            TableRow(Nutriment(
                                title: "Fat",
                                value: String((product.nutriments?.fat)!),
                                dailyNeed: String(round((((product.nutriments?.fat)! / 56) * 100) * 10) / 10) + "%")) }
                        if (product.nutriments?.sugars != nil) {
                            TableRow(Nutriment(
                                title: "Sugars",
                                value: String((product.nutriments?.sugars)!),
                                dailyNeed: String(round((((product.nutriments?.sugars)! / 24) * 100) * 10) / 10) + "%")) }
                        if (product.nutriments?.carbohydrates != nil) {
                            TableRow(Nutriment(
                                title: "Carbohydrates",
                                value: String((product.nutriments?.carbohydrates)!),
                                dailyNeed: String(round((((product.nutriments?.carbohydrates)! / 275) * 100) * 10 ) / 10) + "%")) }
                    }
                    .frame(width: 400, height: 400)
                }
                .padding()
            }
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
