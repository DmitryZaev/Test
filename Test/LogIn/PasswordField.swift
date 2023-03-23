//
//  PasswordField.swift
//  Test
//
//  Created by Dmitry Victorovich on 23.03.2023.
//

import SwiftUI

struct PasswordField: View {
    
    @Binding var passwordSecured: Bool
    @Binding var passwordText: String
    @FocusState var passwordIsFocused
    
    var body: some View {
//MARK: Background & Visible/Invisible button
        ZStack {
            RoundedRectangle(cornerRadius: 14.5)
                .frame(height: 29)
                .foregroundColor(Color(red: 0.91, green: 0.91, blue: 0.91))
                .overlay(alignment: .trailing) {
                    Image(passwordSecured ? "eye" : "eye.slash")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color(red: 0.361, green: 0.361, blue: 0.361))
                        .padding(.trailing, 15)
                        .onTapGesture {
                            passwordSecured.toggle()
                        }
                }

//MARK: - Password Field
            if passwordSecured {
                SecureField("",
                            text: $passwordText,
                            prompt: Text("Password").foregroundColor(Color(red: 0.482, green: 0.482, blue: 0.482)))
                .focused($passwordIsFocused)
                .modifier(PasswordModifire())
            } else {
                TextField("",
                          text: $passwordText,
                          prompt: Text("Password").foregroundColor(Color(red: 0.482, green: 0.482, blue: 0.482)))
                .focused($passwordIsFocused)
                .modifier(PasswordModifire())
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

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordField(passwordSecured: .constant(false),
                      passwordText: .constant(""))
    }
}
