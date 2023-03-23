//
//  NetworkService.swift
//  Test
//
//  Created by Dmitry Victorovich on 23.03.2023.
//

import Foundation
import Combine

//MARK: - Protocol
protocol NetworkServiceProtocol {
    func getLatestProducts() -> AnyPublisher<Latest, Error>
    func getFlashSaleProducts() -> AnyPublisher<FlashSale, Error>
    func getWords() -> AnyPublisher<Words, Error>
    func getDetailedProduct() -> AnyPublisher<DetailedProduct, Error>
}

//MARK: - Implementation
class NetworkService: NetworkServiceProtocol {
    let networkManager = NetworkManager()
    
    enum NetworkLinks {
        static let latest =    "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
        static let flashSale = "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
        static let search =    "https://run.mocky.io/v3/4c9cd822-9479-4509-803d-63197e5a9e19"
        static let detailed =  "https://run.mocky.io/v3/f7f99d04-4971-45d5-92e0-70333383c239"
    }
    
    func getLatestProducts() -> AnyPublisher<Latest, Error> {
        let latest: AnyPublisher<Latest, Error> = networkManager.fetchProducts(urlString: NetworkLinks.latest )
        return latest
    }
    
    func getFlashSaleProducts() -> AnyPublisher<FlashSale, Error> {
        let flashSale: AnyPublisher<FlashSale, Error> = networkManager.fetchProducts(urlString: NetworkLinks.flashSale)
        return flashSale
    }
    
    func getWords() -> AnyPublisher<Words, Error> {
        let words: AnyPublisher<Words, Error> = networkManager.fetchProducts(urlString: NetworkLinks.search)
        return words
    }
    
    func getDetailedProduct() -> AnyPublisher<DetailedProduct, Error> {
        let detProduct: AnyPublisher<DetailedProduct, Error> = networkManager.fetchProducts(urlString: NetworkLinks.detailed)
        return detProduct
    }
}
