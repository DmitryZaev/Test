//
//  ProfilePhotoView.swift
//  Test
//
//  Created by Dmitry Victorovich on 11.03.2023.
//

import SwiftUI
import PhotosUI

struct ProfilePhotoView: View {
    
    @State var selectedItems = [PhotosPickerItem]()
    @Binding var imageData: Data?
    
    var body: some View {
//MARK: - Image
        ZStack {
            if let data = imageData,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image("defaultPhoto")
                    .resizable()
            }
        }
        .frame(width: 60, height: 60)
        .cornerRadius(30)
        .overlay {
            Circle()
                .stroke(Color(red: 0.753, green: 0.753, blue: 0.753), lineWidth: 1)
        }
        
        Spacer().frame(height: 9)
        
//MARK: - ImagePicker
        PhotosPicker(selection: $selectedItems,
                     maxSelectionCount: 1,
                     matching: .images) {
            Text("Change photo")
                .font(.custom("Montserrat", size: 8))
                .foregroundColor(Color(red: 0.502, green: 0.502, blue: 0.502))
            
        }.onChange(of: selectedItems) { newValue in
            guard let item = selectedItems.first else { return }
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    guard let data else { return }
                    DispatchQueue.main.async {
                        self.imageData = data
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ProfilePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoView(imageData: .constant(nil))
    }
}
