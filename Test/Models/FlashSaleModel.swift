//
//  FlashSaleModel.swift
//  Test
//
//  Created by Dmitry Victorovich on 23.03.2023.
//

import Foundation

struct FlashSale: Decodable {
    let flashSale: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}
