//
//  TestApp.swift
//  Test
//
//  Created by Dmitry Victorovich on 10.03.2023.
//

import SwiftUI

@main
struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(appCoordinator: AppCoordinator())
                .preferredColorScheme(.light)
        }
    }
}
