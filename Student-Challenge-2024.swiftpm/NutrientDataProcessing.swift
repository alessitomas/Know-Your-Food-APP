//
//  NutrientDataProcessing.swift
//  Know Your Food
//
//  Created by Tomás Alessi on 24/02/24.
//

import Foundation

extension CameraView{
    // function to extract scales from text
    func extractFirstOccurrence(from text: String) -> String? {
        let prepared_text = text.replacingOccurrences(of: "o", with: "0", options: .caseInsensitive)

        let prepared_text_range = NSRange(location: 0, length: prepared_text.count)
        
        let pattern = "[0-9]?.?[0-9]+m?c?g"
        
        do {

            let regex = try NSRegularExpression(pattern: pattern)
            

            if let match = regex.firstMatch(in: prepared_text, range: prepared_text_range) {

                if let range = Range(match.range, in: prepared_text) {
                    return String(prepared_text[range])
                }
            }
        } catch {

            print(error)
        }
        

        return nil
    }
}
