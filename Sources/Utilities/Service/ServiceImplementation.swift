//
//  ServiceImplementation.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/13.
//

import Foundation

@available(iOS 13.0, *)
public class ServiceImplementation: Service {
    private let headers: [String: String]
    private let urlSession: URLSession
    
    public init(headers: [String: String]? = nil, urlSession: URLSession = .shared) {
        self.headers = headers ?? Self.defaultHeaders
        self.urlSession = urlSession
    }
    
    private static var defaultHeaders: [String: String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    public func get<T: Codable>(url: String) async throws -> T {
        try await request(url: url, method: "GET", parameters: Optional<Data>.none)
    }
    
    public func post<T: Codable, P: Encodable>(url: String, parameters: P) async throws -> T {
        // Encode parameters to JSON Data
        let jsonData = try JSONEncoder().encode(parameters)
        return try await request(url: url, method: "POST", parameters: jsonData)
    }
    
    private func request<T: Codable>(
        url: String,
        method: String,
        parameters: Data?
    ) async throws -> T {
        guard let validURL = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: validURL)
        urlRequest.httpMethod = method
        
        // Set headers
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // Set HTTP body if parameters exist
        if let parameters = parameters {
            urlRequest.httpBody = parameters
        }
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(httpResponse.statusCode)
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                throw NetworkError.decodingError(error)
            }
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
