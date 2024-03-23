//
//  CameraView.swift
//  Know Your Food
//
//  Created by Tomás Alessi on 24/02/24.
//

import SwiftUI
import PhotosUI
import Vision

struct CameraView: View {
    
    //MARK: - Properties 
    
    // nutrient data
    @EnvironmentObject var data : NutrientsInfo
    
    // state varibles for camera
    @State var showCamera = false
    @State var selectedImage: UIImage?
    
    // state varibles for picking photo from libary
    @State var photosPickerItem: PhotosPickerItem?
    
    // state varibles for keeping count of the extracted text and their coordinates
    @State var detected_words : [String] = []
    @State var detected_words_coord : [VNRectangleObservation] = []
    
    // grade of the food label
    @State var food_grade : Int?
    
    // map food labels nutrient prefix to their name
    @State var prefix_to_nutrient_name: [String: String] = [
        "Includes": "Added Sugars",
        "Incl. Added Sugars": "Added Sugars",
        "Vit D" : "Vitamin D",
        "Potas" : "Potassium",
        "Saturated Fat": "Saturated Fat",
        "Sodium": "Sodium",
        "Dietary Fiber":  "Dietary Fiber",
        "Added Sugars": "Added Sugars",
        "Vitamin D": "Vitamin D",
        "Calcium": "Calcium",
        "Potassium": "Potassium",
        "Trans Fat": "Trans Fat",
        "Iron":"Iron"
    ]
    
    
    //MARK: - Body
    var body: some View {
        VStack {
            
            //MARK: - Title
            Text("Food Label Classification")
                .font(.largeTitle)

                .foregroundColor(.black)
                .padding()
            
            Divider()
            
            
            // if a image is selected displays it
            VStack {
                Spacer()
                

                Text("Time to Know Your Food 🥕")
                    .font(.title)
                    .foregroundColor(.black)
                Text((selectedImage != nil) ? "Your image was loaded😁" : "Upload or take a food facts label photo")
                    .font(.title)
                    .minimumScaleFactor(0.6)
                    .foregroundColor((selectedImage != nil) ? Color.green : Color.black)
                    .animation(.easeIn, value: selectedImage)
                    .padding()
                
                if selectedImage != nil{
                    if data.has_nutrient_value() && food_grade != nil {
                        ZStack{
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .frame(minWidth: 2, maxWidth: 250, minHeight: 4,  maxHeight: 350)
                            
                                .foregroundColor(.black)
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                                .shadow(radius: 10)
                                .padding()


                            
                            if food_grade! > 0 {
                                Image("GoodFeedback")
                                    .resizable()
                                    .frame(minWidth: 2, maxWidth: 250, minHeight: 4,  maxHeight: 350)
                                
                                    .foregroundColor(.black)
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                                    .shadow(radius: 10)
                                    .padding()
                                    .transition(.scale)
                            }
                            else if food_grade! == 0 {
                                Image("MediumFeedback")
                                    .resizable()
                                    .frame(minWidth: 2, maxWidth: 250, minHeight: 4,  maxHeight: 350)
                                
                                    .foregroundColor(.black)
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                                    .shadow(radius: 10)
                                    .padding()
                                    .transition(.scale)
                            }
                            else if food_grade! < 0 {
                                Image("BadFeedback")
                                    .resizable()
                                    .frame(minWidth: 2, maxWidth: 250, minHeight: 4,  maxHeight: 350)
                                
                                    .foregroundColor(.black)
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 30)
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                                    .shadow(radius: 10)
                                    .padding()
                            }
                            
                            
  
                        }
                    }
                    else{
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .frame(minWidth: 2, maxWidth: 250, minHeight: 4,  maxHeight: 350)
                        
                            .foregroundColor(.black)
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .shadow(radius: 10)
                            .padding()
                        
                    }
                    
                }
                else{
                    Image("NutritianFacts")
                        .resizable()
                        .frame(minWidth: 2, maxWidth: 250, minHeight: 4,  maxHeight: 350)
                    
                        .foregroundColor(.black)
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 2)
                        )
                        .shadow(radius: 10)
                        .padding()
                }

            }
            .padding()
            
            
            // if the button is clickedshowCamera turns to true
            // Happens a screen cover of AccessCameraView, reciving the binding selectedImage
            
            // Buttons
            
            
            VStack {
                
                // buttons start
                HStack(spacing: 20){
                    Button{
                        showCamera.toggle()
                    } label: {
                        Label("Take a photo", systemImage: "camera.fill")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.yellow.opacity( 0.8))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                        
                    }
                    .fullScreenCover(isPresented: $showCamera) {
                        AccessCameraView(selectedImage: $selectedImage)
                    }
                    
                    PhotosPicker(selection: $photosPickerItem, matching: .images) {
                        Label("Uplaod Image", systemImage: "photo.badge.plus.fill")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color(red: 120/255, green: 172/255, blue: 94/255, opacity: 0.8))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .onChange(of: photosPickerItem){ _ in
                        Task{
                            if let photosPickerItem{
                                let data_image = try? await photosPickerItem.loadTransferable(type: Data.self)
                                if let image = UIImage(data:data_image!) {
                                    
                                    selectedImage = image

        
                                }
                            }
                        }
                    
                        
                    
                    }
                    
                    Button{
                        selectedImage = nil
                        
                    } label: {
                        Label("Remove Image", systemImage: "trash.fill")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    
                }
                .padding()
                
                
                // buttons end
                Spacer()
               
                if selectedImage != nil{
                    if data.has_nutrient_value(){
                        NavigationLink{
                            DetailsView()
                                .navigationTitle("Nutrients Overview")
    
                            
                                
                        } label: {
                            HStack(spacing: 320){
                                Text("Time to Know Your Food")
                                    .foregroundColor(.black)
                                Image(systemName: "arrow.forward")
                                    .foregroundColor(.black)
                            }
     
                            
                        
                        }
                        .padding()
                        .background(Color.orange.opacity(0.6))
                        .cornerRadius(10)
                        .shadow(radius: 10)

                    }
                    else{
                        VStack{
                            Text("No nutrient was detected in your photo")
                                .font(.headline)
                                
                                .foregroundColor(.black)
                                .padding([.top, .leading, .trailing])
                                .animation(.bouncy.delay(1), value: selectedImage)
                                
                            
                            Text("Please make sure that the food label is clear in yout photo")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding([.bottom, .leading, .trailing])
                                .animation(.bouncy.delay(1), value: selectedImage)

                        }
                        .padding()
                        .background(Color.orange.opacity(0.3))
                        .cornerRadius(10)

                    }

                }
                else{
                    
                    
                }
                
                
            
                Spacer()
            }
            
   
            
  
            


            Spacer()
            
        }
        .onChange(of: selectedImage) { _ in
            if let image = selectedImage {
                
                data.erase_extracted_values_and_grades()
                food_grade = nil
                recognize_text_from_image(input_image: image)
                extract_data_from_recognized_text()
                detected_words = []
                detected_words_coord = []
                food_grade = data.grade_all_nutrients()
                
            }
        }
        .background(
            Image("BackgroundOficial-0%")
                .resizable()
                .scaledToFill()
        )
        
    }
    
}
















//MARK: - Preview
#Preview {
    CameraView()
}
