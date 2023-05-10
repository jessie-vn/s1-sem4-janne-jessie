//
//  DetailsView.swift
//  IOS
//
//  Created by Janne van Seggelen on 08/05/2023.
//

import SwiftUI

struct DetailsView: View {
    var product: Product
    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                    Image(product.image)
                        .resizable()
                        .frame(width: 400, height: 400)
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
            product: Product(image: "AH-Appelstroop", title: "title", vegan: false, description: "description", code: "1")
        )
    }
}
