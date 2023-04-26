//
//  CartViewBlock.swift
//  IOS
//
//  Created by Janne van Seggelen on 26/04/2023.
//

import SwiftUI

struct CartViewBlock: View {
    var charts: [Chart]
    var body: some View {
        HStack {
            ForEach(charts) { chart in
                VStack {
                    Text(chart.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.62, green: 0.908, blue: 0.754))
                        .font(.system(size: 20))
                    Image(chart.content)
                        /*.padding(10)
                        .background(Color(red: 0.62, green: 0.908, blue: 0.754))
                        .foregroundColor(.white)
                        .cornerRadius(20)*/
                        .resizable()
                        .frame(width: 75, height: 75)
                }
            }
            .frame(maxWidth: 150)
        }
    }
}

class Chart: Identifiable {
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}

struct CartViewBlock_Previews: PreviewProvider {
    static var previews: some View {
        CartViewBlock(
            charts: [Chart]()
        )
    }
}
