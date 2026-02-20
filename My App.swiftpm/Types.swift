import SwiftUI
import Foundation

struct FoodNutrient : Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
    let amount: Float
    let unitName: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case amount
        case unitName
    }
}

struct FoodItem : Identifiable, Codable {
    let id: UUID = UUID()
    let description: String
    let nutrients: [FoodNutrient]
    
    private enum CodingKeys: String, CodingKey {
        case description
        case nutrients
    }
}
