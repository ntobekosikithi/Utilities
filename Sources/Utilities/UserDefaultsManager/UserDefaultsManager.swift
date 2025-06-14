//
//  UserDefaultsManager.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/14.
//

import Foundation

public final class UserDefaultsManager: @unchecked Sendable {
    public static let shared = UserDefaultsManager()
    
    private let defaults: UserDefaults
    
    private init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    // MARK: - String

    public func save(_ value: String, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    public func retrieve(forKey key: String) -> String? {
        return defaults.string(forKey: key)
    }

    // MARK: - Codable

    public func save<T: Codable>(_ value: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: key)
    }

    public func retrieve<T: Codable>(_ type: T.Type, forKey key: String) throws -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
