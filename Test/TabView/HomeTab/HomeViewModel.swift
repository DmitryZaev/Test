//
//  HomeViewModel.swift
//  Test
//
//  Created by Dmitry Victorovich on 12.03.2023.
//

import Foundation
import Combine

//MARK: - Protocol
protocol HomeViewModelProtocol: CanUseNetworkProtocol {
    typealias HomeProduct = [(name: String?,
                          category: String?,
                          price: String?,
                          discount: Int?,
                          imageUrlString: String?)]
    var userImageData: Data? { get set }
    var latestArray: HomeProduct { get set }
    var flashSalesArray: HomeProduct { get set }
    var latestLoaded: Bool { get set }
    var flashSalesLoaded: Bool { get set }
    
    associatedtype SearchVMProt: SearchViewModelProtocol
    associatedtype DetailedVMProt: DetailedViewModelProtocol
    var searchViewModel: SearchVMProt { get }
    var detailedViewModel: DetailedVMProt { get }
}

//MARK: -Implementation
final class HomeViewModel: HomeViewModelProtocol {
    @Published var userImageData: Data?
    @Published var latestArray: HomeProduct = []
    @Published var flashSalesArray: HomeProduct = []
    @Published var latestLoaded = false
    @Published var flashSalesLoaded = false
    
    var networkManager: NetworkManagerProtocol?
    var searchViewModel: SearchViewModel
    var detailedViewModel: DetailedViewModel
    
    var cancellable: Set<AnyCancellable> = []
    
    init(searchViewModel: any SearchViewModelProtocol, detailedViewModel: any DetailedViewModelProtocol) {
        self.searchViewModel = searchViewModel as! SearchViewModel
        self.detailedViewModel = detailedViewModel as! DetailedViewModel
    }
    
    func getData() {
        latestLoaded = false
        flashSalesLoaded = false
        networkManager?.fetchProducts(.latest)
            .map{ $0 as Latest}
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("Latest data Ok")
                    self?.latestLoaded = true
                case .failure(let error):
                    print("Latest data error - \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] latest in
                guard let latest = latest.latest else { return }
                latest.forEach {
                    self?.latestArray.append((name: $0.name,
                                              category: $0.category,
                                              price: self?.getPriceStringFrom(double: $0.price,
                                                                              decimals: "3"),
                                              discount: nil,
                                              imageUrlString: $0.imageUrl))
                }
            })
            .store(in: &cancellable)
        
        networkManager?.fetchProducts(.flashSale)
            .map{ $0 as FlashSale}
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("Flash sale data Ok")
                    self?.flashSalesLoaded = true
                case .failure(let error):
                    print("Flash sale data error - \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] flashSale in
                guard let flashSale = flashSale.flashSale else { return }
                flashSale.forEach {
                    self?.flashSalesArray.append((name: $0.name,
                                                  category: $0.category,
                                                  price: self?.getPriceStringFrom(double: $0.price,
                                                                                  decimals: "2"),
                                                  discount: $0.discount,
                                                  imageUrlString: $0.imageUrl))
                }
            })
            .store(in: &cancellable)
    }
    
    private func getPriceStringFrom(double: Double?, decimals: String) -> String? {
        guard let double else { return nil }
        let string = String(format: "%.\(decimals)f", double).replacingOccurrences(of: ".", with: ",")
        return string
    }
}

