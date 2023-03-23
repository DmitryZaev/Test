//
//  DetailedProductModel.swift
//  Test
//
//  Created by Dmitry Victorovich on 23.03.2023.
//

import Foundation

struct DetailedProduct: Decodable {
    let name: String?
    let description: String?
    let rating: Double?
    let numberOfReviews: Int?
    let price: Double?
    let colors: [String]?
    let imageUrls: [String]?
    var priceString: String {
        guard let price else { return ""}
        return String(format: "%.2f", price).replacingOccurrences(of: ".", with: ",")
    }
    var ratingString: String? {
        guard let rating else { return nil }
        return String(format: "%.1f", rating)
    }
    var numberOfReviewsString: String? {
        guard let numberOfReviews else { return nil }
        return String(describing: numberOfReviews)
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description, rating, price, colors
        case numberOfReviews = "number_of_reviews"
        case imageUrls = "image_urls"
    }
}
