//
//  GoalType.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/16.
//

import Foundation

public enum GoalType: String, CaseIterable, Codable, Sendable {
    case workoutCount = "Workout Count"
    case totalDuration = "Total Duration"
    case distance = "Distance"
    case calories = "Calories"
    case steps = "Steps"
    case specificWorkout = "Specific Workout Type"
    
    public var systemImage: String {
        switch self {
        case .workoutCount: return "number.circle"
        case .totalDuration: return "clock"
        case .distance: return "location"
        case .calories: return "flame"
        case .steps: return "figure.walk.motion"
        case .specificWorkout: return "target"
        }
    }
    
    public var defaultUnit: String {
        switch self {
        case .workoutCount: return "workouts"
        case .totalDuration: return "minutes"
        case .distance: return "km"
        case .calories: return "kcal"
        case .steps: return "steps"
        case .specificWorkout: return "sessions"
        }
    }

    public var compatibleWorkoutTypes: [WorkoutType] {
        switch self {
        case .workoutCount, .totalDuration, .calories:
            return WorkoutType.allCases 
        case .distance:
            return [.running, .cycling, .swimming, .walking]
        case .steps:
            return [.running, .walking, .sports]
        case .specificWorkout:
            return WorkoutType.allCases
        }
    }
}
