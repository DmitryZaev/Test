//
//  MainView.swift
//  Test
//
//  Created by Dmitry Victorovich on 10.03.2023.
//

import SwiftUI

struct MainView<Coordinator: AppCoordinator>: View {
    
    @StateObject var appCoordinator: Coordinator

    var body: some View {
        ZStack {
            Color(red: 0.98, green: 0.976, blue: 1)
//Selecting view by ViewItem
            switch appCoordinator.currentView {
            case .signIn:
                SignInView(viewModel: appCoordinator.signInViewModel)
            case .logIn:
                LogInView(viewModel: appCoordinator.logInViewModel)
            case .tabView:
                MainTabView(tabCoordinator: appCoordinator.tabCoordinator)
            default:
                EmptyView()
            }
        }
        .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(appCoordinator: AppCoordinator())
    }
}
