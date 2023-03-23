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
    var userImageData: Data? { get set }
    var latestArray: [Product] { get set }
    var flashSalesArray: [Product] { get set }
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
    @Published var latestArray: [Product] = []
    @Published var flashSalesArray: [Product] = []
    @Published var latestLoaded = false
    @Published var flashSalesLoaded = false
    
    var networkService: NetworkServiceProtocol?
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
        
        networkService?.getLatestProducts()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case.finished:
                    print("Latest data Ok")
                    self?.latestLoaded = true
                case .failure(let error):
                    print("Latest data error - \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] value in
                guard let latest = value.latest else { return }
                self?.latestArray = latest
            })
            .store(in: &cancellable)
        
        networkService?.getFlashSaleProducts()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case.finished:
                    print("Flash sale data Ok")
                    self?.flashSalesLoaded = true
                case .failure(let error):
                    print("Flash sale data error - \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] value in
                guard let flashSale = value.flashSale else { return }
                self?.flashSalesArray = flashSale
            })
            .store(in: &cancellable)
    }
}

