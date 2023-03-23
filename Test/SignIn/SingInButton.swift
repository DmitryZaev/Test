//
//  SingInButton.swift
//  Test
//
//  Created by Dmitry Victorovich on 23.03.2023.
//

import SwiftUI

struct SingInButton: View {
    
    @Binding var didPressed: Bool?
    var pressed: () -> Void
    
    var body: some View {
        Button {
            pressed()
            didPressed?.toggle()
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
}

struct SingInButton_Previews: PreviewProvider {
    static var previews: some View {
        SingInButton(didPressed: .constant(false)) {}
    }
}
