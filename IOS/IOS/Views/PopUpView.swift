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
    let id: String = "your_id"
    
    
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
            Text("You scanned code: \(scannerCode)").foregroundColor(.black)
                .padding(.bottom, 20)
            if scannerCode.hasSuffix("13") {
                Image("check")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } else {
                Image("cross")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
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
        PopUpView(scannerCode: .constant("code"))
    }
}
