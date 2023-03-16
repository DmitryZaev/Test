//
//  BlockItemFooterView.swift
//  Test
//
//  Created by Dmitry Victorovich on 13.03.2023.
//

import SwiftUI

struct BlockItemFooterView: View {
    
    let blockType: BlockItem
    let price: String?
    
    let priceFontSize: CGFloat
    let plusButtonRadius: CGFloat
    
    init(blockType: BlockItem, price: String?) {
        self.blockType = blockType
        self.price = price
        
        switch blockType {
        case .latest, .brands:
            self.priceFontSize = 8
            self.plusButtonRadius = 20
        case .flashSale:
            self.priceFontSize = 10
            self.plusButtonRadius = 35
        }
    }
    
    var body: some View {
        HStack {
//MARK: - Price
            if let price {
                Text("$ \(price)")
                    .font(.custom("Poppins", size: priceFontSize))
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .baselineOffset(blockType == .flashSale ? 0 : -5)
            }
            
            Spacer()
                
            HStack(spacing: 5) {
                if blockType == .flashSale {
//MARK: - Favorites Button
                    Button {
                        print("Add to favorites")
                    } label: {
                        ZStack {
                            Circle()
                                .tint(Color(red: 0.898, green: 0.914, blue: 0.937))
                            Image("heartPic")
                                .resizable()
                                .frame(width: 14, height: 12, alignment: .center)
                                .foregroundColor(Color(red: 0.329, green: 0.333, blue: 0.537))
                        }
                        .frame(width: 28,
                               height: 28)
                    }
                }
//MARK: - Add to cart Button
                Button {
                    print("Add to cart")
                } label: {
                    ZStack {
                        Circle()
                            .tint(Color(red: 0.898, green: 0.914, blue: 0.937))
                        Image("plusPic")
                            .resizable()
                            .frame(width: plusButtonRadius / 2.5, height: plusButtonRadius / 2.5, alignment: .center)
                            .foregroundColor(Color(red: 0.329, green: 0.333, blue: 0.537))
                    }
                    .frame(width: plusButtonRadius,
                           height: plusButtonRadius)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct BlockItemFooterView_Previews: PreviewProvider {
    static var previews: some View {
        BlockItemFooterView(blockType: .flashSale,
                            price: "540,00")
    }
}
