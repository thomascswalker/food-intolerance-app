import SwiftUI
import Foundation

struct ContentView: View {
    @State private var foods = [FoodItem]()
    
    var body: some View {
        VStack {
            Text("Foods").fontWeight(.bold)
            Spacer(minLength: 20)
            Table(foods) {
                TableColumn("Name", value: \.name)
                TableColumn("Nutrients") { food in
                    GroupBox {
                        ForEach(food.nutrients) { nutrient in
                            Text(nutrient.name + ", " + nutrient.value + nutrient.unit)
                        }  
                    }
                }    
            }
            .tableColumnHeaders(.visible)
            .environment(\.defaultMinListRowHeight, 80) // Set your desired minimum height
        }.onAppear {
            if let newData: [FoodItem] = loadJson(filename: "Foods") {
                foods = newData
            }
        }
    }
}
