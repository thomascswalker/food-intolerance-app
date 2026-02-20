import SwiftUI
import Foundation

struct FoodNutrient : Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
    let value: String
    let unit: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case value
        case unit
    }
}

struct FoodItem : Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
    let nutrients: [FoodNutrient]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case nutrients
    }
}

func loadJson<T: Codable>(filename fileName: String) -> T? {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("Error: Could not find \(fileName) in bundle.")
        return nil
    }
    
    guard let data = try? Data(contentsOf: url) else {
        print("Error: Could not load \(fileName) from bundle.")
        return nil
    }
    
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Error: Failed to decode \(fileName) from bundle: \(error.localizedDescription): \(error.self)")
        return nil
    }
}

struct ContentView: View {
    @State private var foods = [FoodItem]()
    
    var body: some View {
        VStack {
            Text("Foods").fontWeight(.bold)
            Spacer(minLength: 20)
            Table(foods) {
                TableColumn("Name", value: \.name)
                TableColumn("Nutrients") { food in
                    List(food.nutrients) { nutrient in
                        Text(nutrient.name + ", " + nutrient.value + nutrient.unit)
                    }  
                }
            }
            .tableColumnHeaders(.visible)
        }.onAppear {
            if let newData: [FoodItem] = loadJson(filename: "Foods") {
                foods = newData
            }
        }
    }
}
