//
//  HomeView.swift
//  Student-Challenge-2024
//
//  Created by Tomás Alessi on 15/02/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var currentPage: Int
    
    var body: some View {
        // ALL VIEW
        VStack {
            VStack {
                
                // TITLE
                VStack {
                    HStack {
                        Text("Know Your Food")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                        Image("CarrotLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 60, maxHeight: 70)
                    }
                    
                }

                Divider()
                
                // CONTENT
                VStack(alignment: .leading) {
          
                    
                    // CONTEXT
                    VStack(alignment: .leading, spacing: 10) {
                        Text("1. Context of the Problem")
                            .font(.title2)
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)
        
                        
                        Text("Poor nutrition is a relevent problem in the World right now and specifically in the United States.")
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)
 
                        
            
                        
                        Text("Most people in the United States consume too much sodium, saturated fat, and sugar, increasing their risk of chronic diseases, like Heart Disease and Stroke, Type 2 Diabetes and Cancer.")
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)
                 
                        
        
                        
                        Text("Having a healthy diet is crucial to prevent these chronic diseases.")
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)
         
                        
                        Text("Source of data: Centers for Disease Control and Prevention (CDC).")
                            .font(.caption)
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)
    
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.3))
                    .cornerRadius(10)


                    
                    // CAUSE
                    VStack(alignment: .leading, spacing: 10) {
                        Text("2. One of the Causes of the Problem")
                            .font(.title2)
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)

                        
                        Text("Food facts labels are often not intuitive, making it difficult for people to understand it.")
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)

                        
                        Text("This way, the packing looks is commonly used to compare different foods.")
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.red.opacity(0.3))
                    .cornerRadius(10)
                    

                    
                    // APP SOLUTION
                    VStack(alignment: .leading, spacing: 10) {
                        Text("3. App Solution for the Problem")
                            .font(.title2)
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)

                        
                        Text("I develop this app to improve nutrition awareness, by helping people easily understand  composition and the nutrient quantity of the food they are eating.")
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)
   
                        
                        Text("Easily use the information from food labels to choose a healthy diet by taking a photo of the Nutrition Facts Label, and receiving its feedback.")
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)
    
                    }
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(10)
                    

                    
                    // APP SOLUTION
                    VStack(alignment: .leading, spacing: 10) {
                        Text("4. Grading System")
                            .font(.title2)
                            .foregroundColor(.black)
                            .minimumScaleFactor(0.6)

                        
                        Text("The grading system was made based on the Food and Drug Administration (FDA) and Dietary Guidelines for Americans (DGA), where Dietary Fiber, Vitamin D, Calcium, Potassium and Iron, are identified as nutrients to get more of, while Saturated Fat, Sodium, Added Sugars,  are identified as nutrients to get less of, trans fat should be avoided.")
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)

                        
                        Text("5% DV or less of a nutrient per serving is considered low and 20% DV or more  is considered high, nutrients to get more of receive good grade if in high levels, and bad if in low levels, while with nutrient to get less of are the opposite.")
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)
                        
                        Text("The final grade is green if there are more good nutrient grades than bad, red if there are more bad nutrient grades than good, and yellow good and bad nutrient grades are the same.")
                            .minimumScaleFactor(0.6)
                            .foregroundColor(.black)

                    }
                    .padding()
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(10)
                }
                .padding()

                Button {
                    currentPage = 2
                } label: {
                    Label("Start now!", systemImage: "photo")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                
                

            }
            .padding()
        }
        .background(
            Image("BackgroundOficial-0%")
                .resizable()
                .scaledToFill()
        )

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(currentPage: .constant(0))
    }
}
