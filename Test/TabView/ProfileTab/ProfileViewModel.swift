//
//  ProfileViewModel.swift
//  Test
//
//  Created by Dmitry Victorovich on 11.03.2023.
//

import Foundation

//MARK: - Protocol
protocol ProfileViewModelProtocol: CanChangeTabProtocol, CanChangeViewProtocol {
    var nameText: String { get set }
    var photoData: Data? { get set }
    var photoDataPublisher: Published<Data?>.Publisher { get }
    var balance: Double { get set }
    var logoutPressed: Bool { get set }
    var backButtonPressed: Bool { get set }
}

//MARK: - Implementation
final class ProfileViewModel: ProfileViewModelProtocol {
    @Published var currentView: ViewItem?
    var currentViewPublisher: Published<ViewItem?>.Publisher  { $currentView }
    @Published var currentTab: TabItem?
    var currentTabPublisher: Published<TabItem?>.Publisher { $currentTab }
    @Published var nameText = "Satria Adhi Pradana"
    @Published var photoData: Data?
    var photoDataPublisher: Published<Data?>.Publisher { $photoData }
    @Published var balance: Double = 1593.0
    
    var logoutPressed = false {
        didSet {
            currentView = .signIn
            currentTab = .home
            photoData = nil
        }
    }
    
    var backButtonPressed = false {
        didSet {
            currentTab = .home
        }
    }
}
