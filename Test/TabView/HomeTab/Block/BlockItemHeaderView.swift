//
//  BlockItemHeaderView.swift
//  Test
//
//  Created by Dmitry Victorovich on 13.03.2023.
//

import SwiftUI

struct BlockItemHeaderView: View {
    
    let discount: Int?
    
    var body: some View {
        HStack(alignment: .top) {
//MARK: - manImage
            Image("manPic")
                .resizable()
                .frame(width: 25, height: 25)
                .cornerRadius(12.5)
                .overlay {
                    Circle()
                        .stroke(Color(red: 0.725, green: 0.725, blue: 0.725),
                                lineWidth: 1)
                }
            
            Spacer()
//MARK: - Discount
            if let discount {
                Text("    \(discount)% off    ")
                    .font(.custom("Poppins", size: 10))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .frame(height: 18)
                            .foregroundColor(Color(red: 0.976, green: 0.227, blue: 0.227))
                    }
                
            }
        }
        .padding(.leading, -3)
        .padding(.trailing, 3)
    }
}

struct BlockItemHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        BlockItemHeaderView(discount: 30)
    }
}
