import SwiftUI
import Foundation

struct ContentView: View {
    @State private var foods = [FoodItem]()
    @State private var searchText: String = ""
    
    var body: some View {
            NavigationStack {
                Table(searchResults) {
                    TableColumn("Name", value: \.description)
                    TableColumn("Nutrients") { food in
                        GroupBox {
                            ForEach(food.nutrients) { nutrient in
                                Text(nutrient.name + ", " + nutrient.amount.description + nutrient.unitName)
                            }  
                        }
                    }    
                }
                .navigationTitle("Foods")
                .tableColumnHeaders(.visible)
                .environment(\.defaultMinListRowHeight, 80) // Set your desired minimum height
            }
            .searchable(text: $searchText)
            .onAppear {
                if let newData: [FoodItem] = loadJson(filename: "USDAFoods") {
                    foods = newData
                }
            }
        
        var searchResults: [FoodItem] {
            if searchText.isEmpty {
                return foods
            } else {
                return foods.filter{$0.description.contains(searchText)}
            }
        }
    }
}
