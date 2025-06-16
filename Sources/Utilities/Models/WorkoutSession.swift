//
//  WorkoutSession.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/16.
//

import Foundation

public struct WorkoutSession: Identifiable, Codable, Equatable, Sendable {
    public let id: UUID
    public let type: WorkoutType
    public let startTime: Date
    public var endTime: Date?
    public var status: WorkoutStatus
    public var duration: TimeInterval
    public var pausedAt: Date?
    public var resumedAt: Date?
    public var calories: Int?
    public var distance: Double?
    public var steps: Int?
    
    public var durationInMinutes: Double {
        return duration / 60
    }

    public var estimatedCalories: Int {
        if let calories = calories {
            return calories
        }
        return Int(durationInMinutes * type.caloriesPerMinute)
    }
    
    public var estimatedDistance: Double? {
        if let distance = distance {
            return distance
        }
        guard let distancePerMinute = type.distancePerMinute else { return nil }
        return durationInMinutes * distancePerMinute
    }

    public var estimatedSteps: Int? {
        if let steps = steps {
            return steps
        }
        guard let stepsPerMinute = type.stepsPerMinute else { return nil }
        return Int(durationInMinutes * stepsPerMinute)
    }
    
    public init(
        id: UUID,
        type: WorkoutType,
        startTime: Date,
        endTime: Date? = nil,
        status: WorkoutStatus = .inProgress,
        duration: TimeInterval = 0,
        pausedAt: Date? = nil,
        resumedAt: Date? = nil,
        calories: Int? = nil,
        distance: Double? = nil,
        steps: Int? = nil 
    ) {
        self.id = id
        self.type = type
        self.startTime = startTime
        self.endTime = endTime
        self.status = status
        self.duration = duration
        self.pausedAt = pausedAt
        self.resumedAt = resumedAt
        self.calories = calories
        self.distance = distance
        self.steps = steps
    }
}
