//
//  CartViewBlock.swift
//  IOS
//
//  Created by Janne van Seggelen on 26/04/2023.
//

import SwiftUI

struct CartViewBlock: View {
    var title: String
    var products: [ProductInfo]
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                .font(.system(size: 20))
                .padding(.bottom, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(products) { product in
                        NavigationLink {
                            DetailsView(
                                product: product
                            )
                        }
                        label: {
                            VStack {
                                /*Text(product.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                                    .font(.system(size: 15))*/
                                AsyncImage(url: URL(string: product.image_url!)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 75, height: 75).padding(10)
                            }
                        }
                    }
                }
            }
            //.frame(maxWidth: 150)
            .padding(.bottom, 20)

        }
    }
}

struct CartViewBlock_Previews: PreviewProvider {
    static var previews: some View {
        CartViewBlock(
            title: "",
            products: [ProductInfo]()
        )
    }
}
