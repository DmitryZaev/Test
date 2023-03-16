//
//  KeychainManager.swift
//  Test
//
//  Created by Dmitry Victorovich on 10.03.2023.
//

import Security
import Foundation

//MARK: - Protocol
protocol KeychainManagerProtocol {
    func save(firstName: String, lastName: String, email: String) throws
    func getAttributesFor(firstName: String) throws -> [String]
}

//MARK: - Implementation
class KeychainManager: KeychainManagerProtocol {
    
    enum KeychainErrors: Error {
        case duplicateEntry
        case unknown(OSStatus)
        case noData
    }
    
    //MARK: - Save to Database
    func save(firstName: String, lastName: String, email: String) throws {
        
        let data = Data([lastName, email].joined(separator: "*****").utf8)

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: firstName,
            kSecValueData: data
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainErrors.duplicateEntry
        }
        guard status == errSecSuccess else {
            throw KeychainErrors.unknown(status)
        }
    }
    
    //MARK: - Load from Database
    func getAttributesFor(firstName: String) throws -> [String] {
        let item = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: firstName,
            kSecReturnData: true,
        ] as CFDictionary
        
        var result : AnyObject?
        
        let status = SecItemCopyMatching(item, &result)
        guard status == errSecSuccess else {
            throw KeychainErrors.unknown(status)
        }
        guard let data = result as? Data,
              let dataString = String(data: data, encoding: .utf8) else {
            throw KeychainErrors.noData
        }
        
        let attributes = dataString.components(separatedBy: "*****")
        
        return attributes
    }
}

