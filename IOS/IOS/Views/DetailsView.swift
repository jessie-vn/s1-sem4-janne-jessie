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
    
    private func calculateWeightProcentage(value: Double?, weightProcentage: Double?) -> Double? {
        if value != nil && weightProcentage != nil {
            var result = (value)! / (weightProcentage)! * 100
            result = round(result * 10) / 10
            return result
        }
        return 0
    }
    
    private func calculateDailyNeed(value: Double?, dailyNeed: Double) -> Double? {
        if value != nil {
            var result = ((value)! * 100) / dailyNeed
            result = round(result * 10) / 10
            return result
        }
        return 0
    }
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
                    .foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
                    .font(.system(size: 25))
                Text(product._id)
                    .foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
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
                            .font(.system(size: 20))
                    }
                    else {
                        Image("vegan-no")
                            .resizable()
                            .frame(width: 30, height: 30)
                        Text("This product is not vegan")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.88, green: 0.271, blue: 0.273))
                            .font(.system(size: 20))
                    }
                }
                .padding(.bottom, 10)
                
                //MARK: Hardcoded so its easier to combine our products objects
                
                Text("Product backstory")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
                Text(product.description)
                    .foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.top, -25)
                
                Text("Ingredient list")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
                if (product.ingredients_text == nil) {
                    Text("Ingredients unknown")
                        .foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.top, -25)
                }
                else{
                    Text(product.ingredients_text!)
                        .foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.top, -25)
                }
                
                    HStack {
//                        Text("Nutritional values")
//                            .fontWeight(.bold)
//                            .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
//                            .padding()
                        if hovered == 0 { Text("Contains").foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941)).fontWeight(.bold).padding() }
                        else if hovered == 1 { Text("Daily Need (%)").foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941)).fontWeight(.bold).padding() }
                        else { Text("Weight Procentage (%)").foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941)).fontWeight(.bold).padding() }
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
                            let weightProcentage = calculateWeightProcentage(value: product.nutriments?.vitamin_b12, weightProcentage: product.nutriments?.net_weight_value)
                            let dailyNeed = calculateDailyNeed(value: product.nutriments?.vitamin_b12, dailyNeed: 5)
                            if weightProcentage != 0 {
                                TableRow(Nutriment(
                                    title: "Vitimine B12",
                                    value: String((product.nutriments?.vitamin_b12)!),
                                    dailyNeed: String(dailyNeed!) + "%",
                                    weightProcentage: String(weightProcentage!) + "%"))
                            }
                            else {
                                TableRow(Nutriment(
                                    title: "Vitimine B12",
                                    value: String((product.nutriments?.vitamin_b12)!),
                                    dailyNeed: String(dailyNeed!) + "%"))
                            }
                        }
                        if (product.nutriments?.iron != nil) {
                            let dailyNeed = calculateDailyNeed(value: product.nutriments?.iron, dailyNeed: 18)
                            let weightProcentage = calculateWeightProcentage(value: product.nutriments?.iron, weightProcentage: product.nutriments?.net_weight_value)
                            if weightProcentage != 0 {
                                TableRow(Nutriment(
                                    title: "Iron",
                                    value: String((product.nutriments?.iron)!),
                                    dailyNeed: String(dailyNeed!) + "%",
                                    weightProcentage: String(weightProcentage!) + "%"))
                            }
                            else {
                                TableRow(Nutriment(
                                    title: "Iron",
                                    value: String((product.nutriments?.iron)!),
                                    dailyNeed: String(dailyNeed!) + "%")) }
                        }
                        if (product.nutriments?.calcium != nil) {
                            let dailyNeed = calculateDailyNeed(value: product.nutriments?.calcium, dailyNeed: 5)
                            let weightProcentage = calculateWeightProcentage(value: product.nutriments?.calcium, weightProcentage: product.nutriments?.net_weight_value)
                            if weightProcentage != 0 {
                                TableRow(Nutriment(
                                    title: "Calcium",
                                    value: String((product.nutriments?.calcium)!),
                                    dailyNeed: String(dailyNeed!) + "%",
                                    weightProcentage: String(weightProcentage!) + "%"))
                            }
                            else {
                                TableRow(Nutriment(
                                    title: "Calcium",
                                    value: String((product.nutriments?.calcium)!),
                                    dailyNeed: String(dailyNeed!) + "%"))
                            }
                        }
                        if (product.nutriments?.fibre != nil) {
                            let dailyNeed = calculateDailyNeed(value: product.nutriments?.fibre, dailyNeed: 5)
                            let weightProcentage = calculateWeightProcentage(value: product.nutriments?.fibre, weightProcentage: product.nutriments?.net_weight_value)
                            if weightProcentage != 0 {
                                TableRow(Nutriment(
                                    title: "Fibre",
                                    value: String((product.nutriments?.fibre)!),
                                    dailyNeed: String(dailyNeed!) + "%",
                                    weightProcentage: String(weightProcentage!) + "%"))
                            }
                            else {
                                TableRow(Nutriment(
                                    title: "Fibre",
                                    value: String((product.nutriments?.fibre)!),
                                    dailyNeed: String(dailyNeed!) + "%"))
                            }
                        }
                        if (product.nutriments?.fat != nil) {
                            let dailyNeed = calculateDailyNeed(value: product.nutriments?.fat, dailyNeed: 5)
                            let weightProcentage = calculateWeightProcentage(value: product.nutriments?.fat, weightProcentage: product.nutriments?.net_weight_value)
                            if weightProcentage != 0 {
                                TableRow(Nutriment(
                                    title: "Fat",
                                    value: String((product.nutriments?.fat)!),
                                    dailyNeed: String(dailyNeed!) + "%",
                                    weightProcentage: String(weightProcentage!) + "%"))
                            }
                            else {
                                TableRow(Nutriment(
                                    title: "Fat",
                                    value: String((product.nutriments?.fat)!),
                                    dailyNeed: String(dailyNeed!) + "%"))
                            }
                        }
                        if (product.nutriments?.sugars != nil) {
                            let dailyNeed = calculateDailyNeed(value: product.nutriments?.sugars, dailyNeed: 5)
                            let weightProcentage = calculateWeightProcentage(value: product.nutriments?.sugars, weightProcentage: product.nutriments?.net_weight_value)
                            if weightProcentage != 0 {
                                TableRow(Nutriment(
                                    title: "Sugars",
                                    value: String((product.nutriments?.sugars)!),
                                    dailyNeed: String(dailyNeed!) + "%",
                                    weightProcentage: String(weightProcentage!) + "%"))
                            }
                            else {
                                TableRow(Nutriment(
                                    title: "Sugars",
                                    value: String((product.nutriments?.sugars)!),
                                    dailyNeed: String(dailyNeed!) + "%"))
                            }
                        }
                        if (product.nutriments?.carbohydrates != nil) {
                            let dailyNeed = calculateDailyNeed(value: product.nutriments?.carbohydrates, dailyNeed: 5)
                            let weightProcentage = calculateWeightProcentage(value: product.nutriments?.carbohydrates, weightProcentage: product.nutriments?.net_weight_value)
                            if weightProcentage != 0 {
                                TableRow(Nutriment(
                                    title: "Carbohydrates",
                                    value: String((product.nutriments?.carbohydrates)!),
                                    dailyNeed: String(dailyNeed!) + "%",
                                    weightProcentage: String(weightProcentage!) + "%"))
                            }
                            else {
                                TableRow(Nutriment(
                                    title: "Carbohydrates",
                                    value: String((product.nutriments?.carbohydrates)!),
                                    dailyNeed: String(dailyNeed!) + "%"))
                            }
                        }
                    }
                    .frame(width: 400, height: 400)
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
