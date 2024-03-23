//
//  DetailsView.swift
//  Know Your Food
//
//  Created by Tomás Alessi on 20/02/24.
//

import SwiftUI

struct DetailsView: View {
//    @Binding var nutrient_value: [String: String]
    @EnvironmentObject var data : NutrientsInfo
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Strengths").font(.headline)){
                    ForEach (data.nutrients){ nutrient in
                        if let grade = nutrient.grade, grade > 0{
                                HStack{
                                    Text("🟢")
                                        .font(.caption)
                                    VStack(alignment: .leading){
                                        Text(nutrient.name)
                                            .foregroundStyle(.black)
                                            .font(.caption)
                                        Text(nutrient.feedback_message ?? "N/A")
                                            .foregroundStyle(.gray)
                                            .font(.caption2)
                                    }
                                    Spacer()
                                    Text(nutrient.extracted_value ?? "N/A")
                                        .font(.caption)
                                }
                                .listRowBackground(Color(red: 243/255, green: 240/255, blue: 207/255))

                             
          
                        }
                    }
                    
                }
                .foregroundStyle(.black)
                
                Section(header: Text("Neutral").font(.headline)){
                    ForEach (data.nutrients){ nutrient in
                        if let grade = nutrient.grade, grade == 0{
       
                            HStack{
                                Text("🟡")
                                    .font(.caption)
                                VStack(alignment: .leading){
                                    Text(nutrient.name)
                                        .foregroundStyle(.black)
                                        .font(.caption)
                                    Text(nutrient.feedback_message ?? "N/A")
                                        .foregroundStyle(.gray)
                                        .font(.caption2)
                                }
                                Spacer()
                                Text(nutrient.extracted_value ?? "N/A")
                                    .font(.caption)
                            }
                            .listRowBackground(Color(red: 243/255, green: 240/255, blue: 207/255))
                        }
                    }
                }
                .foregroundStyle(.black)
            
                Section(header: Text("Weaknesses").font(.headline)){
                    ForEach (data.nutrients){ nutrient in
                        if let grade = nutrient.grade, grade < 0{
       
                            HStack{
                                Text("🔴")
                                    .font(.caption)
                                VStack(alignment: .leading){
                                    Text(nutrient.name)
                                        .foregroundStyle(.black)
                                        .font(.caption)
                                    Text(nutrient.feedback_message ?? "N/A")
                                        .foregroundStyle(.gray)
                                        .font(.caption2)
                                }
                                Spacer()
                                Text(nutrient.extracted_value ?? "N/A")
                                    .font(.caption)
                            }
                            .listRowBackground(Color(red: 243/255, green: 240/255, blue: 207/255))
                             
                            
         
                        }
                    }
                }
                .foregroundStyle(.black)
                        
            }

            .background{
                Image("BackgroundOficial-0%")
                    .resizable()
                    .scaledToFill()
            }
            .scrollContentBackground(.hidden)
        
        }
        
    }
}

