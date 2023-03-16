//
//  CustomTextField.swift
//  Test
//
//  Created by Dmitry Victorovich on 10.03.2023.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var text: String
    @FocusState var fieldIsFocused: Bool
    let placeholder: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14.5)
                .frame(height: 29)
                .foregroundColor(Color(red: 0.91, green: 0.91, blue: 0.91))
            
            TextField("",
                      text: $text,
                      prompt: Text(placeholder).foregroundColor(Color(red: 0.482, green: 0.482, blue: 0.482)))
            .multilineTextAlignment(.center)
            .font(.custom("Montserrat", size: 11))
            .keyboardType(placeholder == "Email" ? .emailAddress : .default)
            .foregroundColor(.black)
            .baselineOffset(1.5)
            .frame(height: 29)
            .focused($fieldIsFocused)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant("Placeholder"),
                        placeholder: "Placeholder")
    }
}
