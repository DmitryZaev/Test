//
//  CanUseNetworkProtocol.swift
//  Test
//
//  Created by Dmitry Victorovich on 15.03.2023.
//

import Foundation
import Combine

protocol CanUseNetworkProtocol: ObservableObject {
    var networkManager: NetworkManagerProtocol? { get }
    var cancellable: Set<AnyCancellable> { get set }
    func getData()
    func clearCancellable()
}

extension CanUseNetworkProtocol {
    func clearCancellable() {
        cancellable.removeAll()
    }
}
