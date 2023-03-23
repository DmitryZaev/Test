//
//  NetworkManager.swift
//  Test
//
//  Created by Dmitry Victorovich on 12.03.2023.
//

import Foundation
import Combine

//MARK: - Protocol
protocol NetworkManagerProtocol {
    func fetchProducts<T : Decodable>(urlString: String) -> AnyPublisher<T, Error>
}

//MARK: - Implementation
class NetworkManager: NetworkManagerProtocol {
    
    func fetchProducts<T : Decodable>(urlString: String) -> AnyPublisher<T, Error> {
        
        guard let url = URL(string: urlString)
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
