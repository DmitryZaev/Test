//
//  ProductModel.swift
//  Test
//
//  Created by Dmitry Victorovich on 23.03.2023.
//

import Foundation

struct Product: Decodable {
    let category: String?
    let name: String?
    let price: Double?
    let discount: Int?
    let imageUrl: String?
    var latestPrice: String? {
        guard let price else { return nil }
        return String(format: "%.3f", price).replacingOccurrences(of: ".", with: ",")
    }
    var flashSalePrice: String? {
        guard let price else { return nil }
        return String(format: "%.2f", price).replacingOccurrences(of: ".", with: ",")
    }
    
    enum CodingKeys: String, CodingKey {
        case category, name, price, discount
        case imageUrl = "image_url"
    }
}
