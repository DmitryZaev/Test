//
//  DetailedViewModel.swift
//  Test
//
//  Created by Dmitry Victorovich on 14.03.2023.
//

import Foundation
import Combine

//MARK: - Protocol
protocol DetailedViewModelProtocol: CanChangeTabProtocol, CanUseNetworkProtocol {
    var goToCart: Bool { get set }
    var name: String? { get set }
    var description: String? { get set }
    var rating: String? { get set }
    var numberOfReviews: String? { get set }
    var price: Double? { get set }
    var priceString: String { get set }
    var colors: [String]? { get set }
    var imageUrls: [String] { get set }
    var quantity: Int { get set }
    func getSummString() -> String
}
    
//MARK: - Implementation
final class DetailedViewModel: DetailedViewModelProtocol {
    @Published var currentTab: TabItem?
    var currentTabPublisher: Published<TabItem?>.Publisher { $currentTab }
    @Published var goToCart = false {
        didSet {
            currentTab = .cart
        }
    }
    @Published var name: String?
    @Published var description: String?
    @Published var rating: String?
    @Published var numberOfReviews: String?
    @Published var price: Double?
    @Published var priceString: String = ""
    @Published var colors: [String]?
    @Published var imageUrls: [String] = []
    @Published var quantity = 1
    
    var networkManager: NetworkManagerProtocol?
    
    var cancellable: Set<AnyCancellable> = []
    
    func getData() {
        networkManager?.fetchProducts(.detailed)
            .map{ $0 as DetailedProduct }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Detailed data Ok")
                case .failure(let error):
                    print("Detailed data error - \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] detaledProduct in
                self?.name = detaledProduct.name
                self?.description = detaledProduct.description
                if let detRating = detaledProduct.rating {
                    self?.rating = String(format: "%.1f", detRating)
                }
                if let detNumbOfRev = detaledProduct.numberOfReviews {
                    self?.numberOfReviews = String(describing: detNumbOfRev)
                }
                if let detPrice = detaledProduct.price {
                    self?.price = detPrice
                    self?.priceString = String(format: "%.2f", detPrice).replacingOccurrences(of: ".", with: ",")
                }
                self?.price = detaledProduct.price
                self?.colors = detaledProduct.colors
                self?.imageUrls = detaledProduct.imageUrls ?? []
            })
            .store(in: &cancellable)
    }
    
    func getSummString() -> String {
        guard let price else { return "" }
        let summ = price * Double(quantity)
        let string = String(format: "%.2f", summ).replacingOccurrences(of: ".", with: ",")
        return string
    }
}
