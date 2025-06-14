//
//  HTTPHeaders+Extensions.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/13.
//

import Foundation
import Alamofire

extension HTTPHeaders {
    /// Creates headers with authentication token
    /// - Parameter token: Bearer token
    /// - Returns: HTTPHeaders with authorization
    public static func withBearerToken(_ token: String) -> HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }
    
    /// Creates headers with API key
    /// - Parameters:
    ///   - key: API key value
    ///   - headerName: Name of the API key header (default: "X-API-Key")
    /// - Returns: HTTPHeaders with API key
    public static func withAPIKey(_ key: String, headerName: String = "X-API-Key") -> HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
            headerName: key
        ]
    }
}
