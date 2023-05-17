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
                            }
                        }
                        PopUpView(scannerCode: $scannerCode, product: $product, navigate: $navigate)
                            .dismiss()

                        PopUpView(scannerCode: $scannerCode, product: $product, navigate: $navigate)
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
                    .fill(Color(red: 0.62, green: 0.908, blue: 0.754))
            )
            .padding(.horizontal, 10)
        }
        .sheet(isPresented: $isPresentingScanner) {
            self.scannerSheet
        }    }
}

struct ScannerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerButtonView(navigate: .constant(false))
    }
}
