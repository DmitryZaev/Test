//
//  SignInView.swift
//  Test
//
//  Created by Dmitry Victorovich on 10.03.2023.
//

import SwiftUI

struct SignInView<ViewModel: SignInViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @FocusState var firstNameIsActive: Bool
    @FocusState var lastNameIsActive: Bool
    @FocusState var emailIsActive: Bool
    
    var body: some View {
        
        VStack {
            Spacer().frame(height: 156)
//MARK: - Header
            Text("Sign in")
                .font(.custom("Montserrat", size: 27))
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 0.086, green: 0.094, blue: 0.149))
            
            Spacer().frame(height: 78)
  
//MARK: - TextFields
            VStack(spacing: 35) {
                CustomTextField(text: $viewModel.firstNameText,
                                fieldIsFocused: _firstNameIsActive,
                                placeholder: "First name")
                
                CustomTextField(text: $viewModel.lastNameText,
                                fieldIsFocused: _lastNameIsActive,
                                placeholder: "Last name")
                
                CustomTextField(text: $viewModel.emailText,
                                fieldIsFocused: _emailIsActive,
                                placeholder: "Email")

//MARK: - SignIn Button
                Button {
                    firstNameIsActive = false
                    lastNameIsActive = false
                    emailIsActive = false
                    viewModel.signIn()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 14.5)
                            .foregroundColor(Color(red: 0.306, green: 0.333, blue: 0.843))
                        
                        Text("Sign in")
                            .foregroundColor(Color(red: 0.919, green: 0.919, blue: 0.919))
                            .font(.custom("Montserrat", size: 14))
                            .bold()
                    }
                    .frame(height: 46)
                }
            }
            .padding(.horizontal, 43)
            
            Spacer().frame(height: 17.5)
            
//MARK: - Login text & button
            HStack {
                Text("Already have an account?")
                    .foregroundColor(Color(red: 0.502, green: 0.502, blue: 0.502))
                
                Button("Log in") {
                    viewModel.logInDidPressed?.toggle()
                }
                .tint(Color(red: 0.145, green: 0.31, blue: 0.902))
                
                Spacer()
            }
            .padding(.horizontal, 42)
            .font(.custom("Montserrat", size: 10))
            
            Spacer().frame(height: 74)
            
//MARK: - Google / Apple buttons
            VStack(alignment: .leading, spacing: 38) {
                Button {
                    print("Sign in with Google")
                } label: {
                    HStack {
                        Image("googlePic")
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                        Text(" Sign in with Google")
                    }
                }
                
                Button {
                    print("Sign in with Apple")
                } label: {
                    HStack {
                        Image("applePic")
                            .resizable()
                            .frame(width: 18, height: 22)
                        
                        Text(" Sign in with Apple")
                    }
                }
            }
            .tint(.black)
            .font(.custom("Montserrat", size: 13))
            
            Spacer()
        }
        .ignoresSafeArea()
        .onDisappear {
            viewModel.firstNameText = ""
            viewModel.lastNameText = ""
            viewModel.emailText = ""
        }
//MARK: - alerts Setup
        .alert("Error",
               isPresented: $viewModel.emailError) {
            Button("OK", action: {})
        } message: {
            Text(viewModel.badEmailText)
        }
        .alert("Error",
               isPresented: $viewModel.userDuplicate) {
            Button("OK", action: {})
        } message: {
            Text(viewModel.duplicateUserText)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel())
    }
}
