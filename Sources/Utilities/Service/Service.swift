//
//  Service.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/13.
//

import Foundation
import Alamofire

@available(iOS 13.0, macOS 10.15, *)
public protocol Service {
    
    /// Performs a GET request and returns a single decoded object
    /// - Parameter url: The endpoint URL as a String
    /// - Returns: Decoded object of type T
    /// - Throws: Network or decoding errors
    func get<T: Codable>(url: String) async throws -> T
    
    /// Performs a POST request
    /// - Parameters:
    ///   - url: The endpoint URL as a String
    ///   - parameters: Parameters to send with the request
    /// - Returns: Decoded response of type T
    /// - Throws: Network or decoding errors
    func post<T: Codable, P: Encodable>(url: String, parameters: P) async throws -> T
}
