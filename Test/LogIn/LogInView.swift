//
//  LogInView.swift
//  Test
//
//  Created by Dmitry Victorovich on 10.03.2023.
//

import SwiftUI

struct LogInView<ViewModel: LogInViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @FocusState var firstNameIsFocused: Bool
    @FocusState var passwordIsFocused: Bool
    
    var body: some View {
        
        VStack {
            Spacer().frame(height: 156)
//MARK: - Header
            Text("Welcome back")
                .font(.custom("Montserrat", size: 27))
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 0.086, green: 0.094, blue: 0.149))
            
            Spacer().frame(height: 81)
            
            VStack(spacing: 35) {
//MARK: - Login Text Field
                CustomTextField(text: $viewModel.firstNameText,
                                fieldIsFocused: _firstNameIsFocused,
                                placeholder: "First name")
                
//MARK: Password Field
                PasswordField(passwordSecured: $viewModel.passwordSecured,
                              passwordText: $viewModel.passwordText,
                              passwordIsFocused: _passwordIsFocused)
            }
            .padding(.horizontal, 43)
            
            Spacer().frame(height: 99)

//MARK: - Login button
            LoginButton(didPressed: $viewModel.loginButtonDidPressed) {
                self.hideKeyboard()
            }
            Spacer()
        }
        .ignoresSafeArea()
        .background {
            Color.white.opacity(0.001)
                .gesture(tapGesture)
        }
        .contentShape(Rectangle())
        .gesture(swipeRight)
        .onDisappear {
            viewModel.firstNameText = ""
            viewModel.passwordText = ""
        }
//MARK: - Alert Settings
        .alert("Error",
               isPresented: $viewModel.firstNameError) {
            Button("OK", action: {})
        } message: {
            Text(viewModel.errorMessage)
        }
    }
    
//MARK:  - Swipe for go back & tap for hide keyboard
    var swipeRight: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.width > 200 {
                    viewModel.goBack()
                }
            }
    }
    
    var tapGesture: some Gesture {
        TapGesture()
            .onEnded {
                hideKeyboard()
            }
    }
    
    private func hideKeyboard() {
        firstNameIsFocused = false
        passwordIsFocused = false
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(viewModel: LogInViewModel())
    }
}
