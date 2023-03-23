//
//  ProfileHeaderView.swift
//  Test
//
//  Created by Dmitry Victorovich on 24.03.2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @Binding var backButtonDidPressed: Bool?
    
    var body: some View {
        HStack {
            Button {
                backButtonDidPressed?.toggle()
            } label: {
                Image("backPic")
                    .resizable()
                    .frame(width: 16)
            }
            Spacer()
            Text("Profile")
                .font(.custom("Montserrat", size: 15))
                .fontWeight(.bold)
            Spacer()
            Spacer().frame(width: 16)

        }
        .frame(height: 16)
        .foregroundColor(.black)
        .padding(.horizontal, 20)
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(backButtonDidPressed: .constant(false))
    }
}
