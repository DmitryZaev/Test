//
//  BlockView.swift
//  Test
//
//  Created by Dmitry Victorovich on 12.03.2023.
//

import SwiftUI

enum BlockItem: String {
    case latest    = "Latest"
    case flashSale = "Flash Sale"
    case brands    = "Brands"
}

struct BlockView: View {
    let block: BlockItem
    let items: [(name: String?,
                 category: String?,
                 price: String?,
                 discount: Int?,
                 imageUrlString: String?)]
    
    let itemSize: CGSize
    let spacing: CGFloat
    let padding: (top: CGFloat,
                  bottom: CGFloat,
                  left: CGFloat,
                  right: CGFloat)
    
    let detailedVM: any DetailedViewModelProtocol
    
    init(block: BlockItem,
         items: [(name: String?,
                  category: String?,
                  price: String?,
                  discount: Int?,
                  imageUrlString: String?)],
         detailedVM: any DetailedViewModelProtocol) {
        self.block = block
        self.items = items
        self.detailedVM = detailedVM
        
        switch block {
        case .latest, .brands:
            itemSize = CGSize(width: 114, height: 149)
            spacing = 12
            padding = (0, 5, 7, 5)
        case .flashSale:
            itemSize = CGSize(width: 174, height: 221)
            spacing = 9
            padding = (7, 7, 10, 4)
        }
    }
    
    var body: some View {
        CustomBlockSection(title: block.rawValue) {
            HStack(spacing: spacing) {
                Spacer().frame(width: 0)
                
                ForEach(items, id: \.name) { item in
                   Group {
                       VStack(alignment: .leading, spacing: 2) {
//MARK: - manImage, discount
                           if block == .flashSale {
                               BlockItemHeaderView(discount: item.discount)
                           }
                           
                           Spacer()
//MARK: - Name, Category
                           BlockItemBodyView(blockType: block,
                                             category: item.category ,
                                             name: item.name,
                                             itemWidth: itemSize.width)
//MARK: - Price, Fafotites & toCart Buttons
                           BlockItemFooterView(blockType: block,
                                               price: item.price)
                       }
                       .padding(.top, padding.top)
                       .padding(.bottom, padding.bottom)
                       .padding(.leading, padding.left)
                       .padding(.trailing, padding.right)
                   }
                   .ignoresSafeArea()
                   .frame(width: itemSize.width)
                   .background {
//MARK: - Image & NavigationLink to DetailedView
                       if block == .flashSale {
                           NavigationLink {
                               DetailedView(viewModel: detailedVM as! DetailedViewModel)
                           } label: {
                               ImageFrom(imageUrlString: item.imageUrlString ?? "")
                           }
                       } else {
                           ImageFrom(imageUrlString: item.imageUrlString ?? "")
                       }
                   }
                   .cornerRadius(10)
                }
                Spacer().frame(width:0)
            }
            .frame(height: itemSize.height)
        }
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(block: .flashSale,
                  items: [(name: "Aaaaaaaa",
                           category: "Bbbbbb",
                           price: "54,00",
                           discount: 30,
                           imageUrlString: "")],
        detailedVM: DetailedViewModel())
    }
}
