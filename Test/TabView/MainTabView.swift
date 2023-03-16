//
//  MainTabView.swift
//  Test
//
//  Created by Dmitry Victorovich on 10.03.2023.
//

import SwiftUI

struct MainTabView<Coordinator: TabCoordinator>: View {
    
    @StateObject var tabCoordinator: Coordinator
    
    var body: some View {
        CustomTabBarView(currentTab: $tabCoordinator.currentTab) {
// Selecting view by TabItem
            switch tabCoordinator.currentTab {
            case .home:
                HomeView(viewModel: tabCoordinator.homeViewModel)
            case .favorites:
                Text("Favorites")
            case .cart:
                Text("Cart")
            case .messages:
                Text("Messages")
            case .profile:
                ProfileView(viewModel: tabCoordinator.profileViewModel)
            case .none:
                EmptyView()
            }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(tabCoordinator: TabCoordinator())
    }
}
