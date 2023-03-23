//
//  LoginBlock.swift
//  Test
//
//  Created by Dmitry Victorovich on 23.03.2023.
//

import SwiftUI

struct LoginBlock: View {
    
    @Binding var didPressed: Bool?
    var pressed: () -> Void
    
    var body: some View {
        HStack {
            Text("Already have an account?")
                .foregroundColor(Color(red: 0.502, green: 0.502, blue: 0.502))
            
            Button("Log in") {
                pressed()
                didPressed?.toggle()
            }
            .tint(Color(red: 0.145, green: 0.31, blue: 0.902))
            
            Spacer()
        }
        .padding(.horizontal, 42)
        .font(.custom("Montserrat", size: 10))
    }
}

struct LoginBlock_Previews: PreviewProvider {
    static var previews: some View {
        LoginBlock(didPressed: .constant(false)) {}
    }
}
