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
    @State private var showProductNotFoundMessage = false
    @Binding var navigate: Bool
    @State var openInfo: Bool = false
    
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
                        .padding(.bottom,20)
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
                        .padding(.bottom,20)
                } else {
                    Image("vegan-no")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(20)
                    Text("This product is **not** vegan")
                        .padding(.bottom,20)
                }
                HStack {
                    ScannerButtonView(navigate: $navigate)
                    Spacer()
                    Button(action: {
                        openInfo = true
                        dismiss()
                    }
                    ) {
                        HStack {
                            Image(systemName: "info.circle")
                            Text("More information")
                        }
                        .frame(width: 160)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color(red: 0.62, green: 0.908, blue: 0.754))
                        )
                        .padding(.horizontal, 10)
                    }
                }
            }
            else if showProductNotFoundMessage{
                Text("This product could not be found")
                    .padding(.bottom,20)
                ScannerButtonView(navigate: $navigate)
            }
            else {
                ProgressView()
                    .padding(.vertical, 20)
            }
        }
        .padding(.vertical, 15)
        .padding(.leading, 24)
        .padding(.trailing, 16)
        .onAppear {
            product = nil
            openInfo = false
            Task {
                do {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        showProductNotFoundMessage = true
                    }
                }
            }
        }
        .onDisappear{
            if openInfo{
                self.navigate.toggle()
            }
        }
    }
    
    func configurePopup(popup: BottomPopupConfig) -> BottomPopupConfig {
        popup
            .activePopupCornerRadius(25)
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        let productInfo = Binding<ProductInfo?>(get: { nil }, set: { _ in })
        return PopUpView(scannerCode: .constant("code"), product: productInfo, navigate: .constant(false))
    }
}
