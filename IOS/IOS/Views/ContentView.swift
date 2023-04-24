//
//  ContentView.swift
//  IOS
//
//  Created by Janne van Seggelen on 24/04/2023.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    @State var isPresentingScanner = false
    @State var scannerCode: String = "Scan a code to get started."
    
    var scannerSheet : some View {
        CodeScannerView(
            codeTypes: [.qr, .code128], // Can add more types to array to be able to scan different type of codes
            completion: { result in
                if case let .success(code) = result {
                    self.scannerCode = code.string
                    self.isPresentingScanner = false
                }
            }
        )
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text(scannerCode)
            Button("Scan a code") {
                self.isPresentingScanner = true
            }
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
