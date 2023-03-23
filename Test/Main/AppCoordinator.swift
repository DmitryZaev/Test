//
//  AppCoordinator.swift
//  Test
//
//  Created by Dmitry Victorovich on 10.03.2023.
//

import Combine

//MARK: -Protocol
protocol AppCoordProtocol: CanChangeViewProtocol {
    associatedtype SignInVMProt: SignInViewModelProtocol
    associatedtype LogInVMProt: LogInViewModelProtocol
    associatedtype TabCoordProt: TabCoordProtocol
    var signInViewModel: SignInVMProt { get }
    var logInViewModel: LogInVMProt { get }
    var tabCoordinator: TabCoordProt { get }
    var keychainManager: KeychainManagerProtocol { get }
    var anyCancellable: Set<AnyCancellable> { get set }
}

//MARK: - Implementation
final class AppCoordinator: AppCoordProtocol {
    @Published var currentView: ViewItem?
    var currentViewPublisher: Published<ViewItem?>.Publisher { $currentView }
    var signInViewModel: SignInViewModel
    var logInViewModel: LogInViewModel
    var tabCoordinator: TabCoordinator
    var keychainManager: KeychainManagerProtocol
    
    var anyCancellable = Set<AnyCancellable>()
    
    init() {
        signInViewModel = SignInViewModel()
        logInViewModel = LogInViewModel()
        tabCoordinator = TabCoordinator()
        
        keychainManager = KeychainManager()
        signInViewModel.keychainManager = keychainManager
        logInViewModel.keychainManager = keychainManager
        
        //MARK: - Observers
        signInViewModel.currentViewPublisher
            .sink { [weak self] view in
                if view == .tabView {
                    self?.tabCoordinator.profileViewModel.configureUser()
                }
                self?.currentView = view
            }
            .store(in: &anyCancellable)
        
        logInViewModel.currentViewPublisher
            .sink { [weak self ] view in
                if view == .tabView {
                    self?.tabCoordinator.profileViewModel.configureUser()
                }
                self?.currentView = view
            }
            .store(in: &anyCancellable)
        
        tabCoordinator.currentViewPublisher
            .sink { [weak self ] view in
                self?.tabCoordinator.profileViewModel.cleanUserData()
                self?.currentView = view
            }
            .store(in: &anyCancellable)
        
        currentView = .signIn
    }
}
