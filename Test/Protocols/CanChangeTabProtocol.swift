//
//  CanChangeTabProtocol.swift
//  Test
//
//  Created by Dmitry Victorovich on 15.03.2023.
//

import Foundation

protocol CanChangeTabProtocol: ObservableObject {
    var currentTab: TabItem? { get set }
    var currentTabPublisher: Published<TabItem?>.Publisher { get }
}

