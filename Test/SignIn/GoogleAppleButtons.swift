//
//  GoogleAppleButtons.swift
//  Test
//
//  Created by Dmitry Victorovich on 23.03.2023.
//

import SwiftUI

struct GoogleAppleButtons: View {
    var body: some View {
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
    }
}

struct GoogleAppleButtons_Previews: PreviewProvider {
    static var previews: some View {
        GoogleAppleButtons()
    }
}
