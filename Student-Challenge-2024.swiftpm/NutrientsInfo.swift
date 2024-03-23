//
//  NutrientsInfo.swift
//  Know Your Food
//
//  Created by Tomás Alessi on 21/02/24.
//

import SwiftUI


class NutrientsInfo : ObservableObject {
    @Published var nutrients = [
        // Nutients to get less of
        Nutrient(name: "Saturated Fat", healty: false, daily_quantity: 20),
        Nutrient(name: "Sodium", healty: false, daily_quantity: 2300),
        Nutrient(name: "Added Sugars", healty: false, daily_quantity: 50),
        Nutrient(name: "Trans Fat", healty: false, daily_quantity: 0),
        // Nutients to get more of
        Nutrient(name: "Dietary Fiber", healty: true, daily_quantity: 28),
        Nutrient(name: "Vitamin D", healty: true, daily_quantity: 20),
        Nutrient(name: "Calcium", healty: true, daily_quantity: 1300),
        Nutrient(name: "Potassium", healty: true, daily_quantity: 4700),
        Nutrient(name: "Iron", healty: true, daily_quantity: 18),
    ]
    
    // erase all attributes that depend on the extraction and are used for feedback
    // function that set the attributes extracted_value, extracted_value_processed, grade and feedback_message to nil in all instances of Nutrient
    func erase_extracted_values_and_grades() {
        for nutrient_index in nutrients.indices{
            nutrients[nutrient_index].extracted_value = nil
            nutrients[nutrient_index].extracted_value_processed = nil
            nutrients[nutrient_index].grade = nil
            nutrients[nutrient_index].feedback_message = nil
        }
    }
    
    func has_nutrient_value() -> Bool{
        let has_value = false
        for nutrient_index in nutrients.indices{
            if nutrients[nutrient_index].extracted_value != nil{
                return true
            }
            
        }
        return has_value
        
    }
    // function that grade every nutrient, and based on the grade of the nutrients return a general grade for the food
    func grade_all_nutrients() -> Int{
        var general_grade = 0
        
        for nutrient_index in nutrients.indices{
            // variable to count the grade of all nutrients of a food to return a general grade
            let low_quantity = Double(nutrients[nutrient_index].daily_quantity) * 5.0 / 100.0
            let high_quantity = Double(nutrients[nutrient_index].daily_quantity) * 20.0 / 100.0
            
            // if the nutrient has a processed value to be graded
            if let processed_value = nutrients[nutrient_index].extracted_value_processed {
                // if it is a nutrient to get more of
                if nutrients[nutrient_index].healty{
                    // if it has a high quantity good grade
                    if processed_value >= high_quantity{
                        nutrients[nutrient_index].grade = 1
                        nutrients[nutrient_index].feedback_message = "High quantity"
                        general_grade += 1
                    }
                    // if it has a low quantity bad grade
                    else if processed_value <= low_quantity{
                        nutrients[nutrient_index].grade = -1
                        nutrients[nutrient_index].feedback_message = "Low quantity"
                        general_grade -= 1
                    }
                    //
                    else{
                        nutrients[nutrient_index].grade = 0
                        nutrients[nutrient_index].feedback_message = "Neutral quantity"
                        
                    }
                }
                // if it is a nutrient to get less of
                else{
                    // if it has a low quantity good grade
                    if processed_value <= low_quantity{
                        nutrients[nutrient_index].grade = 1
                        nutrients[nutrient_index].feedback_message = "Low quantity"
                        general_grade += 1
                    }
                    // if it has a high quantity bad grade
                    else if processed_value >= high_quantity{
                        nutrients[nutrient_index].grade = -1
                        nutrients[nutrient_index].feedback_message = "High quantity"
                        general_grade -= 1
                    }
                    else{
                        nutrients[nutrient_index].grade = 0
                        nutrients[nutrient_index].feedback_message = "Neutral quantity"
                        
                    }

                }
            }

        }
        return general_grade
}
    
    func process_extracted_value( extracted_value_raw :String) -> Double?{
        let range = NSRange(location: 0, length: extracted_value_raw.count)
        let pattern = "[0-9]?.?[0-9]+"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            if let match = regex.firstMatch(in: extracted_value_raw, range: range) {
                if let range = Range(match.range, in: extracted_value_raw) {
                    return (String(extracted_value_raw[range]) as NSString).doubleValue
                }
            }
        } catch {
            print(error)
        }
        
        return nil
    }

    
    func add_and_process_extracted_value( nutrient_name: String, nutrient_extracted_value: String) {
        for nutrient_index in nutrients.indices{
            if nutrients[nutrient_index].name == nutrient_name{
                nutrients[nutrient_index].extracted_value = nutrient_extracted_value
                nutrients[nutrient_index].extracted_value_processed = process_extracted_value(extracted_value_raw: nutrient_extracted_value)
                return
            }
          
        }
    }
    

}

struct  Nutrient : Identifiable {
    var name : String
    var healty : Bool
    var daily_quantity : Int
    
    // Attributes that depend on the extraction and are used for feedback
    var feedback_message: String?
    var extracted_value : String?
    var extracted_value_processed : Double?
    // 1 Good, 0 Mid, -1 Bad
    var grade: Int?
    var id = UUID()
}
