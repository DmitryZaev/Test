//
//  NetworkModels.swift
//  Test
//
//  Created by Dmitry Victorovich on 12.03.2023.
//

import Foundation

//MARK: - For HomeView
struct Latest: Decodable {
    let latest: [Product]?
}

struct FlashSale: Decodable {
    let flashSale: [Product]?
    
    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}

struct Product: Decodable {
    let category: String?
    let name: String?
    let price: Double?
    let discount: Int?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case category, name, price, discount
        case imageUrl = "image_url"
    }
}

//MARK: - For SearchView
struct Words: Decodable {
    let words: [String]?
}

//MARK: - For DetailedView
struct DetailedProduct: Decodable {
    let name: String?
    let description: String?
    let rating: Double?
    let numberOfReviews: Int?
    let price: Double?
    let colors: [String]?
    let imageUrls: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name, description, rating, price, colors
        case numberOfReviews = "number_of_reviews"
        case imageUrls = "image_urls"
    }
}
