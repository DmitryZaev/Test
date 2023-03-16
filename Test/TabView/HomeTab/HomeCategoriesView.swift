//
//  HomeCategoriesView.swift
//  Test
//
//  Created by Dmitry Victorovich on 12.03.2023.
//

import SwiftUI

struct HomeCategoriesView: View {
    
    let viewWidth: CGFloat
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(CategoryItem.allCases, id: \.rawValue) {
                    createCategoryFor(item: $0,
                                      itemWidth: viewWidth / CGFloat(CategoryItem.allCases.count))
                }
            }
        }
    }
//MARK: - Builder for items
    @ViewBuilder private func createCategoryFor(item: CategoryItem, itemWidth: CGFloat) -> some View {
        VStack {
            ZStack {
                Ellipse()
                    .frame(width: 42, height: 38)
                    .foregroundColor(Color(red: 0.933, green: 0.937, blue: 0.957))
                
                Image(item.imageName)
                    .resizable()
                    .frame(width: item.imageSize.width,
                           height: item.imageSize.height)
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color(red: 0.086, green: 0.094, blue: 0.149))
            }
            Spacer().frame(height: 14)
            Text(item.rawValue)
                .font(.custom("Poppins", size: 9))
                .kerning(-0.5)
                .foregroundColor(Color(red: 0.651, green: 0.655, blue: 0.671))
                .lineLimit(1)
        }
        .frame(width: itemWidth)
    }
}

private enum CategoryItem: String, CaseIterable {
    case phones     = "Phones"
    case headphones = "Headphones"
    case games      = "Games"
    case cars       = "Cars"
    case furtiture  = "Furniture"
    case kids       = "kids"
    
    var imageName: String {
        return self.rawValue.lowercased() + "Pic"
    }
    
    var imageSize: CGSize {
        switch self {
        case .phones:     return CGSize(width: 12.5, height: 20.0)
        case .headphones: return CGSize(width: 19.8, height: 17.3)
        case .games:      return CGSize(width: 19.9, height: 10.0)
        case .cars:       return CGSize(width: 20.7, height: 14.5)
        case .furtiture:  return CGSize(width: 21.7, height: 13.0)
        case .kids:       return CGSize(width: 21.3, height: 17.0)
        }
    }
}

struct HomeCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCategoriesView(viewWidth: 375)
    }
}
