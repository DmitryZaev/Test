//
//  DetailedColorsView.swift
//  Test
//
//  Created by Dmitry Victorovich on 15.03.2023.
//

import SwiftUI

struct DetailedColorsView: View {
    
    let colors: [String]?
    @State var selected: Int
    
    var body: some View {
        if let colors {
//MARK: - Text
            VStack(spacing: 10) {
                Text("Color:")
                    .font(.custom("Poppins", size: 10))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.451, green: 0.451, blue: 0.451))
                    .frame(maxWidth: .infinity, alignment: .leading)

//MARK: - Colored Views
                HStack(spacing: 15) {
                    ForEach(0..<colors.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 34, height: 26)
                            .foregroundColor(Color(colors[index]))
                            .overlay {
                                if index == selected {
                                    RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(red: 0.678, green: 0.678, blue: 0.678), lineWidth: 2)
                                }
                            }
                            .onTapGesture {
                                selected = index
                            }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct DetailedColorsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedColorsView(colors: ["#ffffff",
                                    "#b5b5b5",
                                    "#000000"], selected: 0)
    }
}
