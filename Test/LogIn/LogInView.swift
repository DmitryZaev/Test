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
                
//MARK: Visible/Invisible button
                ZStack {
                    RoundedRectangle(cornerRadius: 14.5)
                        .frame(height: 29)
                        .foregroundColor(Color(red: 0.91, green: 0.91, blue: 0.91))
                        .overlay(alignment: .trailing) {
                            Image(viewModel.passwordSecured ? "eye" : "eye.slash")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color(red: 0.361, green: 0.361, blue: 0.361))
                                .padding(.trailing, 15)
                                .onTapGesture {
                                    viewModel.passwordSecured.toggle()
                                }
                        }

//MARK: - Password Field
                    if viewModel.passwordSecured {
                        SecureField("",
                                    text: $viewModel.passwordText,
                                    prompt: Text("Password").foregroundColor(Color(red: 0.482, green: 0.482, blue: 0.482)))
                        .focused($passwordIsFocused)
                        .modifier(PasswordModifire())
                    } else {
                        TextField("",
                                  text: $viewModel.passwordText,
                                  prompt: Text("Password").foregroundColor(Color(red: 0.482, green: 0.482, blue: 0.482)))
                        .focused($passwordIsFocused)
                        .modifier(PasswordModifire())
                    }
                }
            }
            .padding(.horizontal, 43)
            
            Spacer().frame(height: 99)

//MARK: - Login button
            Button {
                firstNameIsFocused = false
                passwordIsFocused = false
                viewModel.login()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 14.5)
                        .foregroundColor(Color(red: 0.306, green: 0.333, blue: 0.843))
                    
                    Text("Login")
                        .foregroundColor(Color(red: 0.919, green: 0.919, blue: 0.919))
                        .font(.custom("Montserrat", size: 14))
                        .bold()
                }
                .frame(height: 46)
                .padding(.horizontal, 43)
            }
            Spacer()
        }
        .ignoresSafeArea()
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
    
//MARK:  - Swipe for go back
    var swipeRight: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.width > 200 {
                    viewModel.goBack()
                }
            }
    }
}

//MARK: - PasswordModifire
private struct PasswordModifire: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .font(.custom("Montserrat", size: 11))
            .baselineOffset(1.5)
            .frame(height: 29)
            .padding(.horizontal, 30)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(viewModel: LogInViewModel())
    }
}
