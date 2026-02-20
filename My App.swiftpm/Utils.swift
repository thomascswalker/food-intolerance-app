import Foundation
import SwiftUI

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
