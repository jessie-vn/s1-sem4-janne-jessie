//
//  PopUpView.swift
//  IOS
//
//  Created by Jessie van Nuenen on 26/04/2023.
//

import SwiftUI
import PopupView

struct PopUpView: BottomPopup {
    @Binding var scannerCode: String
    @Binding var product: Product?
    let id: String = "your_id"
    
    //TODO: Update layout
    func createContent() -> some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: dismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(Color(.systemGray))
                }
            }
            .padding(.bottom, 5)
            if let product = product {
                Text("You scanned \(product.product_name)").foregroundColor(.black)
                if product.isVegan {
                    Image("check")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(20)
                    Text("This product is vegan")
                } else {
                    Image("cross")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(20)
                    Text("This product is **not** vegan")
                }
            }
            else {
                Text("This product could not be found")
            }
        }
        .padding(.vertical, 15)
        .padding(.leading, 24)
        .padding(.trailing, 16)
    }
    func configurePopup(popup: BottomPopupConfig) -> BottomPopupConfig {
        popup
        //            .horizontalPadding(20)
        //            .bottomPadding(42)
            .activePopupCornerRadius(25)
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        let productBinding = Binding<Product?>(
            get: { nil },
            set: { _ in }
        )
        return PopUpView(scannerCode: .constant("code"), product: productBinding)
    }
}
