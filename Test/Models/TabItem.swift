//
//  TabItem.swift
//  Test
//
//  Created by Dmitry Victorovich on 11.03.2023.
//

import Foundation

enum TabItem: CaseIterable {
    case home
    case favorites
    case cart
    case messages
    case profile
    
    var imageName: String {
        switch self {
        case .home:      return "homePic"
        case .favorites: return "favoritesPic"
        case .cart:      return "cartPic"
        case .messages:  return "messagesPic"
        case .profile:   return "profilePic"
        }
    }
    
    var position: Double {
        switch self {
        case .home:      return 0
        case .favorites: return 1
        case .cart:      return 2
        case .messages:  return 3
        case .profile:   return 4
        }
    }
}
