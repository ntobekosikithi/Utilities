//
//  LoadingState.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/14.
//

import Foundation

public enum LoadingState<T> {
    case idle
    case loading
    case loaded(T)
    case error(Error)
    
    public var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    public var data: T? {
        if case .loaded(let data) = self { return data }
        return nil
    }
    
    public var error: Error? {
        if case .error(let error) = self { return error }
        return nil
    }
}
