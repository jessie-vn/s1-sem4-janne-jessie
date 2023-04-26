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
                .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                .font(.system(size: 20))
            VStack {
                Text(content)
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.62, green: 0.908, blue: 0.754))
            .foregroundColor(.white)
            .cornerRadius(20)
        }
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
