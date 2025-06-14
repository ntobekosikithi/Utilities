//
//  NetworkError.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/13.
//

import Foundation

public enum NetworkError: LocalizedError, Equatable {
    case invalidURL
    case requestFailed(Error)
    case httpError(Int)
    case decodingError(Error)
    case noData
    case unknown
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .httpError(let statusCode):
            return "HTTP error with status code: \(statusCode)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .noData:
            return "No data received"
        case .unknown:
            return "An unknown error occurred"
        }
    }
    
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noData, .noData),
             (.unknown, .unknown):
            return true
        case (.httpError(let lhsCode), .httpError(let rhsCode)):
            return lhsCode == rhsCode
        case (.requestFailed(let lhsError), .requestFailed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.decodingError(let lhsError), .decodingError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
