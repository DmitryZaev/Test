//
//  SearchViewModel.swift
//  Test
//
//  Created by Dmitry Victorovich on 14.03.2023.
//

import Foundation
import Combine

//MARK: - Protocol
protocol SearchViewModelProtocol: CanUseNetworkProtocol {
    var dropDownList: [String] { get set }
    var searchText: String { get set }
    var fontSize: CGFloat { get }
    func getOffsetY() -> CGFloat
    func select(text: String)
}

//MARK: - Implementation
final class SearchViewModel: SearchViewModelProtocol {
    @Published var dropDownList: [String] = []
    @Published var searchText = ""
    
    let fontSize: CGFloat = 10
    
    var networkService: NetworkServiceProtocol?
    
    var cancellable: Set<AnyCancellable> = []
    
    func getOffsetY() -> CGFloat {
        return CGFloat(dropDownList.count) * ((fontSize) + 5)
    }
    
    func getData() {
        networkService?.getWords()
                .delay(for: 1, scheduler: RunLoop.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case . failure(let error):
                        print("Search failure - \(error.localizedDescription)")
                    }
                }, receiveValue: { [weak self] value in
                    guard let self,
                          let words = value.words,
                          !words.isEmpty else { return }
                    self.dropDownList.removeAll()
                    words.forEach {
                        if $0.lowercased().contains(self.searchText.lowercased()) {
                            self.dropDownList.append($0)
                        }
                    }
                })
                .store(in: &self.cancellable)
    }
    
    func select(text: String) {
        searchText = text
        dropDownList.removeAll()
    }
}
