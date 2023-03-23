//
//  UploadButton.swift
//  Test
//
//  Created by Dmitry Victorovich on 24.03.2023.
//

import SwiftUI

struct UploadButton: View {
    var body: some View {
        Button {
            print("Upload")
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 14.5)
                    .foregroundColor(Color(red: 0.306, green: 0.333, blue: 0.843))
                
                HStack {
                    Spacer()
                    Image("uploadPic")
                        .resizable()
                        .frame(width: 12, height: 15)
                    Spacer()
                    Text("Upload item")
                        .font(.custom("Montserrat", size: 14))
                        .fontWeight(.semibold)
                    Spacer()
                    Spacer().frame(width: 12)
                    Spacer()
                }
                .foregroundColor(Color(red: 0.919, green: 0.919, blue: 0.919))
            }
            .frame(height: 40)
            .padding(.horizontal, 43)
        }
    }
}

struct UploadButton_Previews: PreviewProvider {
    static var previews: some View {
        UploadButton()
    }
}
