//
//  AcessCameraView.swift
//  Know Your Food
//
//  Created by Tomás Alessi on 24/02/24.
//

import SwiftUI

struct AccessCameraView: UIViewControllerRepresentable {
    // the image that will represents the photo that was taken
    @Binding var selectedImage: UIImage?
    // acess isPresented varible (that is bool showCamera in cameraview)
    @Environment(\.presentationMode) var isPresented


    // configure UIImagePickerControlle instace, and delegate the coordinator
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()

        if UIImagePickerController.isSourceTypeAvailable(.camera){

            imagePicker.sourceType = .camera
//            imagePicker.

            imagePicker.allowsEditing = true

            // providing a delegate object
            imagePicker.delegate = context.coordinator

        }
        else{

        }

        return imagePicker
    }

    // integration between swifiUi and Ukit, that updates changes
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
    // integration between swifiUi and Ukit, manage interactions
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}


class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var picker: AccessCameraView

    init(picker: AccessCameraView) {
        self.picker = picker
    }

    // if the user has finished than update the image and exit camera
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Printing Info")
        print(info)
        print("crop")


        guard let selectedImage = info[.editedImage] as? UIImage else {

            return

        }

        // update selected image to the photo image
        self.picker.selectedImage = selectedImage
        // dismiss the camera view and return the view underneath
        self.picker.isPresented.wrappedValue.dismiss()
    }
}
