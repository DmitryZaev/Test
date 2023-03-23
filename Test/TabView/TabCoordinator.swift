//
//  TabCoordinator.swift
//  Test
//
//  Created by Dmitry Victorovich on 11.03.2023.
//

import Foundation
import Combine

//MARK: - Protocol
protocol TabCoordProtocol: CanChangeViewProtocol, CanChangeTabProtocol {
    associatedtype HomeVMProt: HomeViewModelProtocol
    associatedtype SearchVMProt: SearchViewModelProtocol
    associatedtype ProfileVMProt: ProfileViewModelProtocol
    associatedtype DetailedVMProt: DetailedViewModelProtocol
    var homeViewModel: HomeVMProt { get }
    var profileViewModel: ProfileVMProt { get }
    var searchViewModel: SearchVMProt { get }
    var detailedViewModel: DetailedVMProt { get }
    var networkService: NetworkServiceProtocol { get }
    var pictureCancellable: AnyCancellable? { get }
}

//MARK: - Implemetation
final class TabCoordinator: TabCoordProtocol {
    @Published var currentView: ViewItem?
    var currentViewPublisher: Published<ViewItem?>.Publisher { $currentView }
    @Published var currentTab: TabItem?
    var currentTabPublisher: Published<TabItem?>.Publisher { $currentTab }
    
    var homeViewModel: HomeViewModel
    var profileViewModel: ProfileViewModel
    var searchViewModel: SearchViewModel
    var detailedViewModel: DetailedViewModel
    var networkService: NetworkServiceProtocol
    
    var pictureCancellable: AnyCancellable?
    
    init() {
        searchViewModel = SearchViewModel()
        detailedViewModel = DetailedViewModel()
        
        homeViewModel = HomeViewModel(searchViewModel: searchViewModel,
                                      detailedViewModel: detailedViewModel)
        profileViewModel = ProfileViewModel()
        
        networkService = NetworkService()
        homeViewModel.networkService = networkService
        searchViewModel.networkService = networkService
        detailedViewModel.networkService = networkService
        
        //MARK: - Observers
        profileViewModel.currentTabPublisher
            .assign(to: &$currentTab)
        detailedViewModel.currentTabPublisher
            .assign(to: &$currentTab)
        
        currentTab = .home
        
        profileViewModel.currentViewPublisher
            .assign(to: &$currentView)
        
        pictureCancellable = profileViewModel.userPublisher
            .sink{ [weak self] user in
                self?.homeViewModel.userImageData = user.image
            }
    }
}
