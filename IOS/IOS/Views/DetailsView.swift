//
//  DetailsView.swift
//  IOS
//
//  Created by Janne van Seggelen on 08/05/2023.
//

import SwiftUI

struct DetailsView: View {
    var product: ProductInfo
    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                AsyncImage(url: URL(string: product.image_url!))
//                        .resizable()
                        .frame(width: 400, height: 400)
//                        .padding(.bottom, 30)
                    
                    //Divider()
                    
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
                    
                    
                    Text(product.description)
                        .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                        .multilineTextAlignment(.center)
                        .padding()
            }
            .padding()
        }
        .background(.white)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(
            product: ProductInfo(_id: "1", product_name: "title", ingredients: nil, ingredients_analysis_tags: ["en:non-vegan"], image_url: "AH-Appelstroop", origin: "", manufacturing_places: "", energy_value: "", nutriments: nil)
        )
    }
}
