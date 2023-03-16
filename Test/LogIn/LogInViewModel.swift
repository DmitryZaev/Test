//
//  LogInViewModel.swift
//  Test
//
//  Created by Dmitry Victorovich on 11.03.2023.
//

import Foundation

//MARK: - Protocol
protocol LogInViewModelProtocol: CanChangeViewProtocol {
    var firstNameText: String { get set }
    var passwordText: String { get set }
    var passwordSecured: Bool { get set }
    var firstNameError: Bool { get set }
    var errorMessage: String { get }
    var keychainManager: KeychainManagerProtocol? { get set }
    
    func login()
    func goBack()
}

//MARK: - Implementation
final class LogInViewModel: LogInViewModelProtocol {
    @Published var currentView: ViewItem?
    var currentViewPublisher: Published<ViewItem?>.Publisher { $currentView }
    @Published var firstNameText = ""
    @Published var passwordText = ""
    @Published var passwordSecured = true
    @Published var firstNameError = false
    let errorMessage = "There are no users with this first name."
    
    var keychainManager: KeychainManagerProtocol?
    
    func login() {
        if !firstNameText.isEmpty && !passwordText.isEmpty {
            do {
                _ = try keychainManager?.getAttributesFor(firstName: firstNameText)
                currentView = .tabView
            } catch let error {
                print(error.localizedDescription)
                firstNameError.toggle()
            }
        }
    }
    
    func goBack() {
        currentView = .signIn
    }
}
