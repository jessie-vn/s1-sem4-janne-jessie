//
//  CartView.swift
//  IOS
//
//  Created by Janne van Seggelen on 26/04/2023.
//

import SwiftUI

struct CartViewInline: View {
    var title: String
    var content: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
                .font(.system(size: 20))
            VStack {
                Text(content)
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.30196078431372547, green: 0.45098039215686275, blue: 0.3764705882352941))
            .foregroundColor(.white)
            .cornerRadius(20)
        }
        .padding(.bottom, 30)
    }

}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartViewInline(
            title: "",
            content: ""
        )
    }
}
