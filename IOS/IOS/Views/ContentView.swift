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
            TitleBarView()
            Divider()
            VStack {
                ScrollView {
                    CartViewBlock(
                        title: "Your previous scans:",
                        charts:
                        [
                            Chart(
                                title: "",
                                content: "logo"
                            ),
                            Chart(
                                title: "",
                                content: "logo"
                            ),
                            Chart(
                                title: "",
                                content: "logo"
                            ),
                            Chart(
                                title: "",
                                content: "logo"
                            ),
                            Chart(
                                title: "",
                                content: "logo"
                            ),
                            Chart(
                                title: "",
                                content: "logo"
                            )

                        ]
                    )
                    CartViewInline(
                        title: "Want to know more?",
                        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                    )
                    CartViewBlock(
                        title: "These products might interest you:",
                        charts:
                        [
                            Chart(
                                title: "",
                                content: "logo"
                            ),
                            Chart(
                                title: "",
                                content: "logo"
                            ),
                            Chart(
                                title: "",
                                content: "logo"
                            ),
                            Chart(
                                title: "",
                                content: "logo"
                            ),
                            Chart(
                                title: "",
                                content: "logo"
                            ),
                            Chart(
                                title: "",
                                content: "logo"
                            )

                        ]
                    )
                }
            }
            .padding(30)
            
            Spacer()
            Divider()
            
            Text(scannerCode)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
            Button("Scan a code") {
                self.isPresentingScanner = true
            }
//            .buttonStyle(.borderedProminent)
            .padding(9)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(
                    cornerRadius: 15,
                    style: .continuous
                )
                .fill(Color(red: 0.62, green: 0.908, blue: 0.754))
            )
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
