//
//  BlockItemBodyView.swift
//  Test
//
//  Created by Dmitry Victorovich on 13.03.2023.
//

import SwiftUI

struct BlockItemBodyView: View {
    
    let blockType: BlockItem
    let category: String?
    let name: String?
    let itemWidth: CGFloat
    
    let categoryFontSize: CGFloat
    let nameFontSize: CGFloat
    
    init(blockType: BlockItem, category: String?, name: String?, itemWidth: CGFloat) {
        self.blockType = blockType
        self.category = category
        self.name = name
        self.itemWidth = itemWidth
        
        switch blockType {
        case .latest, .brands:
            self.categoryFontSize = 7
            self.nameFontSize = 9
        case .flashSale:
            self.categoryFontSize = 9
            self.nameFontSize = 14
        }
    }
    
    var body: some View {
//MARK: - Category
        if let category {
            Text("      \(category)      ")
                .font(.custom("Poppins", size: categoryFontSize))
                .fontWeight(.semibold)
                .kerning(-0.2)
                .foregroundColor(Color(red: 0.027, green: 0.024, blue: 0.016))
                .background {
                    RoundedRectangle(cornerRadius: blockType == .flashSale ? categoryFontSize : 6)
                        .frame(height: categoryFontSize * 2)
                        .foregroundColor(Color(red: 0.769, green: 0.769, blue: 0.769, opacity: 0.85))
                }
                .offset(y: blockType == .flashSale ? 25 : 20)
        }
//MARK: - Name
        if let name {
            HStack {
                VStack {
                    Text(name)
                        .font(.custom("Poppins", size: nameFontSize))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .kerning(-0.3)
                        .lineLimit(2)
                    
                    Spacer()
                }
                Spacer().frame(width: itemWidth * 0.3)
            }
            .ignoresSafeArea()
            .frame(height: nameFontSize * 5)
            .offset(y: blockType == .flashSale ? 35 : 25)
        }
    }
}

struct BlockItemBodyView_Previews: PreviewProvider {
    static var previews: some View {
        BlockItemBodyView(blockType: .flashSale,
                          category: "Kids",
                          name: "Snickers",
                          itemWidth: 60)
    }
}
