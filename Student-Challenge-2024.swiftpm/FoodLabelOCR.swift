//
//  FoodLabelOCR.swift
//  Know Your Food
//
//  Created by Tomás Alessi on 24/02/24.
//

import Foundation
import Vision
import Foundation
import PhotosUI

extension CameraView {
    
    func recognize_text_from_image(input_image: UIImage?){
            guard let cg_type_image = input_image?.cgImage else {
                print("Error: Was not able to recognize the Image")
                return
            }
            let image_handler = VNImageRequestHandler(cgImage: cg_type_image, options: [:])
    
            let text_recognize_request = VNRecognizeTextRequest{ request, error in
                guard let observations = request.results as? [VNRecognizedTextObservation], error == nil  else{
                    print("Error: Was not to perfom the request")
                    return
                }

                for observation in observations {
                    guard let top_candidate =
                            observation.topCandidates(1).first else {
                        print("No candidate extracted")
                        continue
                    }
    
                    let extracted_text = top_candidate.string
       
    
                    let string_range = extracted_text.startIndex..<extracted_text.endIndex
                    do {
                        guard let bounding_box = try top_candidate.boundingBox(for: string_range) else{
                            print("Error: bounding_box created was nil")
                            continue
                        }


                        detected_words.append(extracted_text)
                        detected_words_coord.append(bounding_box)
    
    
                    } catch {
                        print(error)
                    }
                }
            }
    
            // perfoming the request and checking for error
            do {
                try image_handler.perform([text_recognize_request])
            }
            catch {
                print(error)
            }
        }

    
    func extract_data_from_recognized_text(){
        // prefixes of nutrients that are on FoodLabels
        let nutrients_prefixes: [String] = ["Trans Fat", "Saturated Fat", "Sodium","Includes", "Incl. Added Sugars", "Dietary Fiber", "Vitamin D", "Calcium", "Iron", "Potassium", "Vit D", "Potas", "Cholesterol"]
        for i in detected_words.indices{
            for nutrient_prefixe in nutrients_prefixes {
                let extracted_text = detected_words[i]
                if let nutrient_name = prefix_to_nutrient_name[nutrient_prefixe] , let prefix_range = extracted_text.range(of: nutrient_prefixe){
                    let prefix_end_index = prefix_range.upperBound
                    // cut the initial part of the detected text until the prefix founded
                    let extracted_text_sliced = String(extracted_text[prefix_end_index...])
                    // extracting the string value of the nutrient mass
                    if let value = extractFirstOccurrence(from: extracted_text_sliced){
                        // process the string value and add it to his respective nutrient at data
                        data.add_and_process_extracted_value(nutrient_name: nutrient_name, nutrient_extracted_value: value)
                    }
                    // if no value is found in the same string, try all the string that are located at the right of the nutrient name
                    else{
                        let bounding_box = detected_words_coord[i]
                        
                        let top_right_nutrient = bounding_box.topRight
                        let bottom_right_nutrient = bounding_box.bottomRight
                        
                        
                        for i in detected_words_coord.indices {
                            
                            
                            let top_left_text = detected_words_coord[i].topLeft
                            let bottom_left_text = detected_words_coord[i].bottomLeft
    
                            // check if text is to the right of the nutrient
                            if top_right_nutrient.x < top_left_text.x && bottom_right_nutrient.x < bottom_left_text.x{
                                // check if the text is bellow the upper limit
                                if top_right_nutrient.y + 0.1 >= top_left_text.y && top_left_text.y > bottom_right_nutrient.y{
                                    // check if the text is above the dowm limit
                                    if bottom_right_nutrient.y - 0.1 <= bottom_left_text.y && bottom_left_text.y < top_right_nutrient.y{
                                        if let value = extractFirstOccurrence(from: detected_words[i]){
                                            // process the string value and add it to his respective nutrient at data
                                            data.add_and_process_extracted_value(nutrient_name: nutrient_name, nutrient_extracted_value: value)
                                            break
                                            
                                        }
                                        
                                    }
                                }
                                
                                
                                
                            }
                        }
                        
                    }
                }
            }
            
            
        }
    }
}
