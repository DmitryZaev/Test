//
//  SignInViewModel.swift
//  Test
//
//  Created by Dmitry Victorovich on 10.03.2023.
//

import Foundation

//MARK: - Protocol
protocol SignInViewModelProtocol: CanChangeViewProtocol {
    var firstNameText: String { get set }
    var lastNameText: String { get set }
    var emailText: String { get set }
    var emailError: Bool { get set }
    var userDuplicate: Bool { get set }
    var badEmailText: String { get }
    var duplicateUserText: String { get }
    var keychainManager: KeychainManagerProtocol? { get }
    var logInDidPressed: Bool? { get set }
    
    func signIn()
}

//MARK: - Implementation
final class SignInViewModel: SignInViewModelProtocol {
    @Published var currentView: ViewItem?
    var currentViewPublisher: Published<ViewItem?>.Publisher { $currentView }
    @Published var firstNameText = ""
    @Published var lastNameText = ""
    @Published var emailText = ""
    @Published var emailError = false
    @Published var userDuplicate = false
    
    let badEmailText = "Email is not correct."
    let duplicateUserText = "This user is already registered."
    
    var keychainManager: KeychainManagerProtocol?
    
    var logInDidPressed: Bool? {
        didSet {
            currentView = .logIn
        }
    }
    
    func signIn() {
        guard !firstNameText.isEmpty,
              !lastNameText.isEmpty,
              !emailText.isEmpty else { return }
        if emailIsValid() {
            do {
                try keychainManager?.save(firstName: firstNameText,
                                          lastName: lastNameText,
                                          email: emailText)
                currentView = .tabView
            } catch let error {
                switch error {
                case KeychainManager.KeychainErrors.duplicateEntry:
                    userDuplicate = true
                default:
                    print(error.localizedDescription)
                }
            }
        } else {
            emailError = true
        }
    }
    
    private func emailIsValid() -> Bool {
        let emailPattern = NSPredicate(format: "SELF MATCHES %@",
                                       "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailPattern.evaluate(with: emailText)
    }
}
