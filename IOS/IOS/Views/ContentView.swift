//
//  ContentView.swift
//  IOS
//
//  Created by Janne van Seggelen on 24/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State var navigate = false
    @State var scannedProducts: [ProductInfo] = []
    
//    var hardcodedProducts: [ProductInfo] = [
//        ProductInfo(
//            image: "AH-Appelstroop",
//            title: "AH Appelstroop",
//            vegan: false,
//            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
//            code: "1"
//        ),
//        ProductInfo(
//            image: "AH-Augurken",
//            title: "AH Augurken",
//            vegan: false,
//            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
//            code: "2"
//        ),
//        ProductInfo(
//            image: "AH-Appelmouse",
//            title: "AH Appelmouse",
//            vegan: false,
//            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
//            code: "3"
//        ),
//        ProductInfo(
//            _id: "4",
//            product_name: "AH Kokosmelk",
//            ingredients: nil,
//            ingredients_analysis_tags: ["en:vegan"],
//            image_url: "AH-KokosMelk", origin: "", manufacturing_places: "", energy_value: "", nutriments: nil
//        ),
//        ProductInfo(
//            _id: "5",
//            product_name: "AH Ketchup",
//            ingredients: nil,
//            ingredients_analysis_tags: ["en:vegan"],
//            image_url: "AH-Ketchup", origin: "", manufacturing_places: "", energy_value: "", nutriments: nil
//            )
//        ),
//        ProductInfo(
//            image: "AH-Peterselie",
//            title: "AH Peterselie",
//            vegan: false,
//            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
//            code: "6"
//        )
//    ]

    var filteredProductList: [ProductInfo] =
        [
            ProductInfo(
                _id: "4",
                product_name: "AH Kokosmelk",
                ingredients: nil,
                ingredients_analysis_tags: ["en:vegan"],
                image_url: "AH-KokosMelk", origin: "", manufacturing_places: "", energy_value: "", nutriments: nil
            ),
            ProductInfo(
                _id: "5",
                product_name: "AH Ketchup",
                ingredients: nil,
                ingredients_analysis_tags: ["en:vegan"],
                image_url: "AH-Ketchup", origin: "", manufacturing_places: "", energy_value: "", nutriments: nil
            )
        ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TitleBarView()
                Divider()
                VStack {
                    ScrollView {
                        CartViewBlock(
                            title: "Your previous scans:",
                            products: scannedProducts.reversed()
                        )
                        CartViewInline(
                            title: "Want to know more?",
                            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                        )
                        CartViewBlock(
                            title: "These products might interest you:",
                            products: filteredProductList
                        )
                    }
                }
                .padding(30)
                NavigationLink("", isActive: $navigate){
                    if(!scannedProducts.isEmpty){
                        DetailsView(product: scannedProducts.last!)
                    }
                }.offset(y: -4800)
                
                Spacer()
                Divider()
                
                Text("Scan a code to get started.")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                ScannerButtonView(navigate: $navigate, scannedProducts: $scannedProducts)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
