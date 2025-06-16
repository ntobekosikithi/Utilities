//
//  WorkoutType.swift
//  Utilities
//
//  Created by Ntobeko Sikithi on 2025/06/16.
//

import Foundation

// Updated to align with GoalType categories
public enum WorkoutType: String, CaseIterable, Codable {
    case running = "Running"
    case cycling = "Cycling"
    case swimming = "Swimming"
    case strength = "Strength Training"
    case yoga = "Yoga"
    case walking = "Walking"
    case cardio = "Cardio"           // NEW: Generic cardio
    case sports = "Sports"           // NEW: Generic sports
    case flexibility = "Flexibility" // NEW: Stretching/flexibility
    
    public var systemImage: String {
        switch self {
        case .running: return "figure.run"
        case .cycling: return "bicycle"
        case .swimming: return "figure.pool.swim"
        case .strength: return "dumbbell"
        case .yoga: return "figure.mind.and.body"
        case .walking: return "figure.walk"
        case .cardio: return "heart.fill"
        case .sports: return "sportscourt"
        case .flexibility: return "figure.flexibility"
        }
    }
    
    // NEW: Map workout types to applicable goal types
    public var applicableGoalTypes: [GoalType] {
        switch self {
        case .running, .walking:
            return [.workoutCount, .totalDuration, .distance, .calories, .steps]
        case .cycling:
            return [.workoutCount, .totalDuration, .distance, .calories]
        case .swimming:
            return [.workoutCount, .totalDuration, .distance, .calories]
        case .strength:
            return [.workoutCount, .totalDuration, .calories]
        case .yoga, .flexibility:
            return [.workoutCount, .totalDuration, .calories]
        case .cardio:
            return [.workoutCount, .totalDuration, .calories]
        case .sports:
            return [.workoutCount, .totalDuration, .calories, .steps]
        }
    }
    
    // NEW: Get calorie burn rate per minute for different workout types
    public var caloriesPerMinute: Double {
        switch self {
        case .running: return 12.0
        case .cycling: return 8.0
        case .swimming: return 14.0
        case .strength: return 6.0
        case .yoga: return 3.0
        case .walking: return 4.0
        case .cardio: return 10.0
        case .sports: return 9.0
        case .flexibility: return 2.5
        }
    }
    
    // NEW: Estimate steps per minute for step-tracking workouts
    public var stepsPerMinute: Double? {
        switch self {
        case .running: return 180.0
        case .walking: return 120.0
        case .sports: return 150.0
        default: return nil
        }
    }
    
    // NEW: Average distance per minute (in km) for distance-tracking workouts
    public var distancePerMinute: Double? {
        switch self {
        case .running: return 0.2    // ~12 km/h pace
        case .cycling: return 0.4    // ~24 km/h pace
        case .swimming: return 0.05  // ~3 km/h pace
        case .walking: return 0.08   // ~5 km/h pace
        default: return nil
        }
    }
}
