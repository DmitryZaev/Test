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
            ProfileHeaderView(backButtonDidPressed: $viewModel.backButtonPressed)
            
            Spacer().frame(height: 18)

//MARK: - Photo
            ProfilePhotoView(imageData: $viewModel.user.image)
            
            Spacer().frame(height: 18)
//MARK: - Name
            Text(viewModel.user.name)
                .font(.custom("Montserrat", size: 15))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.247, green: 0.247, blue: 0.247))
            
            Spacer().frame(height: 33)
            
//MARK: - Upload Button
            UploadButton()
            
//MARK: - List with buttons
            ProfileListView(logoutPressed: $viewModel.logoutPressed,
                            balance: viewModel.user.balance)
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
