//
//  NetworkManager.swift
//  Test
//
//  Created by Dmitry Victorovich on 12.03.2023.
//

import Foundation
import Combine

enum NetworkCategories {
    case latest
    case flashSale
    case search
    case detailed
    
    var link: String {
        switch self {
        case .latest:    return "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
        case .flashSale: return "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
        case .search:    return "https://run.mocky.io/v3/4c9cd822-9479-4509-803d-63197e5a9e19"
        case .detailed:  return "https://run.mocky.io/v3/f7f99d04-4971-45d5-92e0-70333383c239"
        }
    }
}

//MARK: - Protocol
protocol NetworkManagerProtocol {
    func fetchProducts<T : Decodable>(_ category: NetworkCategories) -> AnyPublisher<T, Error>
}

//MARK: - Implementation
class NetworkManager: NetworkManagerProtocol {
    
    func fetchProducts<T : Decodable>(_ category: NetworkCategories) -> AnyPublisher<T, Error> {
        
        guard let url = URL(string: category.link)
        else { return Fail(error: NSError(domain: "Error: Bad URL", code: 400)).eraseToAnyPublisher()}
        
        return Future { promise in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    promise(.failure(error))
                    return
                }
                
                guard let data else { return }
                self.decode(from: data) { (model : T) in
                    promise(.success(model))
                }
            }.resume()
        }
        .eraseToAnyPublisher()
    }
    
    private func decode<T : Decodable>(from data: Data, completion: @escaping (T) -> Void) {
        let decoder = JSONDecoder()
        do {
            let json = try decoder.decode(T.self, from: data)
            completion(json)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
