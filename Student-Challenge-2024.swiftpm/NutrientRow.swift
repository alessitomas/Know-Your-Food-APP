//
//  NutrientRow.swift
//  Know Your Food
//
//  Created by Tomás Alessi on 20/02/24.
//

import SwiftUI

struct NutrientRow: View {
    var nutrient: String
    var nutrient_value: String
 
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text(nutrient)
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                Text(nutrient_value)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()

        }
        .padding()
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }

}

#Preview {
    NutrientRow(nutrient: "Protein", nutrient_value: "10g")
}
