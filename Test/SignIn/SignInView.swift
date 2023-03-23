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
                SingInButton(didPressed: $viewModel.signInDidPressed) {
                    self.hideKeyboard()
                }
            }
            .padding(.horizontal, 43)
            
            Spacer().frame(height: 17.5)
            
//MARK: - Login text & button
            LoginBlock(didPressed: $viewModel.logInDidPressed) {
                self.hideKeyboard()
            }
            
            Spacer().frame(height: 74)
            
//MARK: - Google / Apple buttons
            GoogleAppleButtons()
            
            Spacer()
        }
        .ignoresSafeArea()
        .background {
            Color.white.opacity(0.001)
                .gesture(tapGesture)
        }
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
    
    var tapGesture: some Gesture {
        TapGesture()
            .onEnded {
                hideKeyboard()
            }
    }
    
    private func hideKeyboard() {
        firstNameIsActive = false
        lastNameIsActive = false
        emailIsActive = false
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel())
    }
}
