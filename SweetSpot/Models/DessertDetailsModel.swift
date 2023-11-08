//
//  DetailsModel.swift
//  SweetSpot
//
//  Created by Mollie Whaley on 11/7/23.
//

struct DessertDetails: Codable {
    let meals: [Details]
}

struct Details: Codable {
    
    let name: String
    let instructions: String
    let image: String
    
    var separatedInstructions: [String] { // for text formatting
        return instructions
            .components(separatedBy: "\n")
    }
    var ingredientsAndMeasurementsDict = [String: String]()
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case instructions = "strInstructions"
        case image = "strMealThumb"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.image = try container.decode(String.self, forKey: .image)
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        dynamicContainer.allKeys.forEach { key in // use ingredients/measurements to create dict
            if key.stringValue.hasPrefix("strIngredient") {
                if let ingredient = try? dynamicContainer.decode(String.self, forKey: key), !ingredient.isEmpty {
                    let index = key.stringValue.replacingOccurrences(of: "strIngredient", with: "")
                    if let measurementKey = DynamicCodingKeys(stringValue: "strMeasure\(index)") {
                        if let measurement = try? dynamicContainer.decode(String.self, forKey: measurementKey), !measurement.isEmpty {
                            let alteredMeasurement = measurement.lowercased().trimmingCharacters(in: .whitespaces)
                            let alteredIngredient = ingredient.lowercased().trimmingCharacters(in: .whitespaces)
                            self.ingredientsAndMeasurementsDict[alteredIngredient] = alteredMeasurement
                        }
                    }
                }
            }
        }
    }
}

struct DynamicCodingKeys: CodingKey { // for dynamic amount of measurements/ingredients
    
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int? { return nil }
    
    init?(intValue: Int) { return nil }
    
}

