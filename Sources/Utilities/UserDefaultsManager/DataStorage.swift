//
//  DataStorage.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/14.
//

import Foundation

public protocol DataStorage: AnyObject {
    func saveValue(_ value: String, forKey key: String)
    func retrieveValue(forKey key: String) -> String?
    
    func saveObject<T: Codable>(_ value: T, forKey key: String) throws
    func retrieveObject<T: Codable>(_ type: T.Type, forKey key: String) throws -> T?
}

public final class DataStorageImplementation: @unchecked Sendable, DataStorage {
    private let defaults: UserDefaults

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    // MARK: - String

    public func saveValue(_ value: String, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    public func retrieveValue(forKey key: String) -> String? {
        return defaults.string(forKey: key)
    }

    // MARK: - Codable

    public func saveObject<T: Codable>(_ value: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: key)
    }

    public func retrieveObject<T: Codable>(_ type: T.Type, forKey key: String) throws -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

