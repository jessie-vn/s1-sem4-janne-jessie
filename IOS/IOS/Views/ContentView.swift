//
//  ContentView.swift
//  IOS
//
//  Created by Janne van Seggelen on 24/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State var navigate = false
    
    var hardcodedProducts: [Product] = [
        Product(
            image: "AH-Appelstroop",
            title: "AH Appelstroop",
            vegan: false,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            code: "1"
        ),
        Product(
            image: "AH-Augurken",
            title: "AH Augurken",
            vegan: false,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            code: "2"
        ),
        Product(
            image: "AH-Appelmouse",
            title: "AH Appelmouse",
            vegan: false,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            code: "3"
        ),
        Product(
            image: "AH-KokosMelk",
            title: "AH Kokosmelk",
            vegan: true,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            code: "4"
        ),
        Product(
            image: "AH-Ketchup",
            title: "AH Ketchup",
            vegan: true,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            code: "5"
        ),
        Product(
            image: "AH-Peterselie",
            title: "AH Peterselie",
            vegan: false,
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            code: "6"
        )
    ]
    
    var filteredProductList: [Product] =
        [
            Product(
                image: "AH-KokosMelk",
                title: "AH Kokosmelk",
                vegan: true,
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                code: "4"
            ),
            Product(
                image: "AH-Ketchup",
                title: "AH Ketchup",
                vegan: true,
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                code: "5"
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
                            products: hardcodedProducts
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
                    DetailsView(product: filteredProductList.last!)
                }.offset(y: -4800)
                
                Spacer()
                Divider()
                
                Text("Scan a code to get started.")
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                ScannerButtonView(navigate: $navigate)
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
