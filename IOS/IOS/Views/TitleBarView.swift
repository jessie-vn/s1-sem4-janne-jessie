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
                .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
        }
    }
}

struct TitleBarView_Previews: PreviewProvider {
    static var previews: some View {
        TitleBarView()
    }
}
