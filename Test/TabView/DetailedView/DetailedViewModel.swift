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
    var detailedProduct: DetailedProduct? { get set }
    var quantity: Int { get set }
    var bigImageSize: CGSize { get set }
    var buttonsBlockSize: CGSize { get set }
    var buttonsBlockOffset: CGSize { get set }
    func getSummString() -> String
    func configureSizes(viewSize: CGSize)
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
    @Published var detailedProduct: DetailedProduct?
    @Published var quantity = 1
    var bigImageSize = CGSize()
    var buttonsBlockSize = CGSize()
    var buttonsBlockOffset = CGSize()
    
    var networkService: NetworkServiceProtocol?
    
    var cancellable: Set<AnyCancellable> = []
    
    func getData() {
        networkService?.getDetailedProduct()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Detailed data Ok")
                case .failure(let error):
                    print("Detailed data error - \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] value in
                self?.detailedProduct = value
            })
            .store(in: &cancellable)
    }
    
    func getSummString() -> String {
        guard let price = detailedProduct?.price else { return "" }
        let summ = price * Double(quantity)
        let string = String(format: "%.2f", summ).replacingOccurrences(of: ".", with: ",")
        return string
    }
    
    func configureSizes(viewSize: CGSize) {
        self.bigImageSize = CGSize(width: viewSize.width * 0.875,
                                height: viewSize.height * 0.343)
        self.buttonsBlockSize = CGSize(width: viewSize.width * 0.112,
                                       height: viewSize.height * 0.117)
        self.buttonsBlockOffset = CGSize(width: viewSize.width * 0.416,
                                         height: viewSize.height * 0.079)
    }
}
