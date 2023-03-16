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
}

//MARK: - Implementation
final class AppCoordinator: AppCoordProtocol {
    @Published var currentView: ViewItem?
    var currentViewPublisher: Published<ViewItem?>.Publisher { $currentView }
    var signInViewModel: SignInViewModel
    var logInViewModel: LogInViewModel
    var tabCoordinator: TabCoordinator
    var keychainManager: KeychainManagerProtocol
    
    init() {
        signInViewModel = SignInViewModel()
        logInViewModel = LogInViewModel()
        tabCoordinator = TabCoordinator()
        
        keychainManager = KeychainManager()
        signInViewModel.keychainManager = keychainManager
        logInViewModel.keychainManager = keychainManager
        
        //MARK: - Observers
        signInViewModel.currentViewPublisher
            .assign(to: &$currentView)
        logInViewModel.currentViewPublisher
            .assign(to: &$currentView)
        tabCoordinator.currentViewPublisher
            .assign(to: &$currentView)
        
        currentView = .signIn
    }
}
