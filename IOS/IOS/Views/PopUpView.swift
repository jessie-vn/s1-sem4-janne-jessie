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
    @Binding var product: ProductInfo?
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
                Text("**\(product.product_name)**")
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                if product.isUnknown{
                    Image("vegan-maybe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(20)
                    Text("Could not determine for certain whether this product is vegan")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                else if product.isVegan {
                    Image("vegan-yes")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(20)
                    Text("This product is vegan")
                } else {
                    Image("vegan-no")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(20)
                    Text("This product is **not** vegan")
                }
                Button("More information"){
                    
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
            .activePopupCornerRadius(25)
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        let productBinding = Binding<ProductInfo?>(
            get: { nil },
            set: { _ in }
        )
        return PopUpView(scannerCode: .constant("code"), product: productBinding)
    }
}
