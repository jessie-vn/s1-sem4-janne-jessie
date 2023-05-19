//
//  TitleBarView.swift
//  IOS
//
//  Created by Janne van Seggelen on 26/04/2023.
//

import SwiftUI

struct TitleBarView: View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 50, height: 50)
            Text("VegiScan")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
        }
    }
}

struct TitleBarView_Previews: PreviewProvider {
    static var previews: some View {
        TitleBarView()
    }
}
