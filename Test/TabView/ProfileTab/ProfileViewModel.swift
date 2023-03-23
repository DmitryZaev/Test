//
//  ProfileViewModel.swift
//  Test
//
//  Created by Dmitry Victorovich on 11.03.2023.
//

import Foundation

//MARK: - Protocol
protocol ProfileViewModelProtocol: CanChangeTabProtocol, CanChangeViewProtocol {
    var logoutPressed: Bool { get set }
    var backButtonPressed: Bool? { get set }
    var user: User { get set }
    var userPublisher: Published<User>.Publisher { get }
}

//MARK: - Implementation
final class ProfileViewModel: ProfileViewModelProtocol {
    @Published var currentView: ViewItem?
    var currentViewPublisher: Published<ViewItem?>.Publisher  { $currentView }
    @Published var currentTab: TabItem?
    var currentTabPublisher: Published<TabItem?>.Publisher { $currentTab }
    @Published var user = User(name: "",
                               balance: 0,
                               image: nil)
    var userPublisher: Published<User>.Publisher { $user }
    
    var logoutPressed = false {
        didSet {
            currentView = .signIn
            currentTab = .home
        }
    }
    
    var backButtonPressed: Bool? {
        didSet {
            currentTab = .home
        }
    }
    
    func configureUser() {
        user.name = "Satria Adhi Pradana"
        user.balance = 1593.0
    }
    
    func cleanUserData() {
        user = User(name: "",
                    balance: 0,
                    image: nil)
    }
}
