//
//  CanChangeViewProtocol.swift
//  Test
//
//  Created by Dmitry Victorovich on 15.03.2023.
//

import Foundation

protocol CanChangeViewProtocol: ObservableObject {
    var currentView: ViewItem? { get set }
    var currentViewPublisher: Published<ViewItem?>.Publisher { get }
}
