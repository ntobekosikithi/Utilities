//
//  DataStorage.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/15.
//

import Foundation

public protocol DataStorage {
    func save<T>(_ value: T, forKey key: String)
    func retrieve<T>(forKey key: String, type: T.Type) -> T?
    
    func saveString(_ value: String, forKey key: String)
    func retrieveString(forKey key: String, defaultValue: String) -> String

    func save<T: Codable>(_ object: T, forKey key: String) throws
    func retrieve<T: Codable>(_ type: T.Type, forKey key: String) throws -> T?
    
    func remove(forKey key: String)
    func exists(forKey key: String) -> Bool
    func synchronize()
}


public class DataStorageImplementation: DataStorage {
    private let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    // MARK: - Basic Types
    public func save<T>(_ value: T, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    public func retrieve<T>(forKey key: String, type: T.Type) -> T? {
        return userDefaults.object(forKey: key) as? T
    }

    // MARK: - Specific Types
    public func saveString(_ value: String, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    public func retrieveString(forKey key: String, defaultValue: String = "") -> String {
        return userDefaults.string(forKey: key) ?? defaultValue
    }


    // MARK: - Codable
    public func save<T: Codable>(_ object: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(object)
        userDefaults.set(data, forKey: key)
    }

    public func retrieve<T: Codable>(_ type: T.Type, forKey key: String) throws -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return try JSONDecoder().decode(type, from: data)
    }

    // MARK: - Utilities
    public func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }

    public func exists(forKey key: String) -> Bool {
        return userDefaults.object(forKey: key) != nil
    }

    public func synchronize() {
        userDefaults.synchronize()
    }
}
