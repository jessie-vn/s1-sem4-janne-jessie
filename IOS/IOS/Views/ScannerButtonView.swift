//
//  ScannerButtonView.swift
//  IOS
//
//  Created by Jessie van Nuenen on 10/05/2023.
//

import SwiftUI
import CodeScanner

struct ScannerButtonView: View {
    @State var isPresentingScanner = false
    @State var scannerCode: String = ""
    @State var product: ProductInfo?
    @Binding var navigate: Bool
    @Binding var scannedProducts: [ProductInfo]
    
    var scannerSheet : some View {
            CodeScannerView(
                codeTypes: [.qr, .code128, .ean13], // Can add more types to array to be able to scan different type of codes
                completion: { result in
                    if case let .success(code) = result {
                        self.scannerCode = code.string
                        self.isPresentingScanner = false
                        Task{
                            do{
                                product = try await fetchProductByCode(code: scannerCode)
                                if(product != nil){
                                    if let existingProductIndex = scannedProducts.firstIndex(where: { $0.id == product?.id }) {
                                                // Product already exists in the scannedProducts list, remove it
                                                scannedProducts.remove(at: existingProductIndex)
                                            }
                                    scannedProducts.append(product!)
                                }
                            }
                        }
                        PopUpView(scannerCode: $scannerCode, product: $product, navigate: $navigate, scannedProducts: $scannedProducts)
                            .dismiss()

                        PopUpView(scannerCode: $scannerCode, product: $product, navigate: $navigate, scannedProducts: $scannedProducts)
                            .present()
                    }
                }
            )
        }
    var body: some View {
        Button(action: {
            self.isPresentingScanner = true
        }) {
            HStack {
                Image(systemName: "qrcode.viewfinder")
                Text("New scan")
            }
            .frame(width: 160)
            .padding(10)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
            )
            .padding(.horizontal, 10)
        }
        .sheet(isPresented: $isPresentingScanner) {
            self.scannerSheet
        }    }
}

struct ScannerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerButtonView(navigate: .constant(false), scannedProducts: .constant([]))
    }
}
