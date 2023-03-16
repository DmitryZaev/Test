//
//  ProfileView.swift
//  Test
//
//  Created by Dmitry Victorovich on 11.03.2023.
//

import SwiftUI
import PhotosUI

struct ProfileView<ViewModel : ProfileViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Spacer().frame(height: 63)

//MARK: - Header
            HStack {
                Button {
                    viewModel.backButtonPressed.toggle()
                } label: {
                    Image("backPic")
                        .resizable()
                        .frame(width: 16)
                }
                Spacer()
                Text("Profile")
                    .font(.custom("Montserrat", size: 15))
                    .fontWeight(.bold)
                Spacer()
                Spacer().frame(width: 16)

            }
            .frame(height: 16)
            .foregroundColor(.black)
            .padding(.horizontal, 20)
            
            Spacer().frame(height: 18)

//MARK: - Photo
            ProfilePhotoView(imageData: $viewModel.photoData)
            
            Spacer().frame(height: 18)
//MARK: - Name
            Text(viewModel.nameText)
                .font(.custom("Montserrat", size: 15))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.247, green: 0.247, blue: 0.247))
            
            Spacer().frame(height: 33)
            
//MARK: - Upload Button
            Button {
                print("Upload")
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 14.5)
                        .foregroundColor(Color(red: 0.306, green: 0.333, blue: 0.843))
                    
                    HStack {
                        Spacer()
                        Image("uploadPic")
                            .resizable()
                            .frame(width: 12, height: 15)
                        Spacer()
                        Text("Upload item")
                            .font(.custom("Montserrat", size: 14))
                            .fontWeight(.semibold)
                        Spacer()
                        Spacer().frame(width: 12)
                        Spacer()
                    }
                    .foregroundColor(Color(red: 0.919, green: 0.919, blue: 0.919))
                }
                .frame(height: 40)
                .padding(.horizontal, 43)
            }
            
//MARK: - List with buttons
            ProfileListView(logoutPressed: $viewModel.logoutPressed,
                            balance: viewModel.balance)
            .padding(.leading, 32)
            .padding(.trailing, 46)
            .padding(.top, 8)

            Spacer()

        }
        .ignoresSafeArea()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
