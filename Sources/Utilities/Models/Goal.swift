//
//  Goal.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/16.
//

import Foundation

public struct Goal: Identifiable, Codable, Equatable {
    public let id: UUID
    public let title: String
    public let description: String
    public let type: GoalType
    public let targetValue: Double
    public let unit: String
    public let targetDate: Date
    public let createdAt: Date
    public var isActive: Bool
    public let targetWorkoutType: WorkoutType?
    
    public init(
        id: UUID = UUID(),
        title: String,
        description: String,
        type: GoalType,
        targetValue: Double,
        unit: String,
        targetDate: Date,
        createdAt: Date = Date(),
        isActive: Bool = true,
        targetWorkoutType: WorkoutType? = nil 
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.type = type
        self.targetValue = targetValue
        self.unit = unit
        self.targetDate = targetDate
        self.createdAt = createdAt
        self.isActive = isActive
        self.targetWorkoutType = targetWorkoutType
    }

    public func appliesTo(workoutType: WorkoutType) -> Bool {
        // If goal has a specific workout type, check for match
        if let targetWorkoutType = targetWorkoutType {
            return targetWorkoutType == workoutType
        }

        return type.compatibleWorkoutTypes.contains(workoutType)
    }
}
