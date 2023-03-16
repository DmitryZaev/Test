//
//  HomeNavigationBar.swift
//  Test
//
//  Created by Dmitry Victorovich on 12.03.2023.
//

import SwiftUI

struct HomeNavigationBar: View {
    
    let userImageData: Data?
    
    var body: some View {
        HStack {
//MARK: - Menu button
            Button {
                print("Menu")
            } label: {
                Image("menuPic")
                    .resizable()
                    .frame(width: 22, height: 24)
                    .foregroundColor(.black)
            }
            
            Spacer()
//MARK: - Title
            HStack {
                Text("Trade by")
                    .foregroundColor(.black)
                Text("bata")
                    .foregroundColor(Color(red: 0.306, green: 0.333, blue: 0.843))
            }
            .font(.custom("Montserrat", size: 20))
            .bold()
            
            Spacer()
            
            VStack {
//MARK: - Image
                ZStack {
                    if let data = userImageData,
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                    } else {
                        Image("defaultPhoto")
                            .resizable()
                    }
                }
                .frame(width: 33, height: 31)
                .cornerRadius(15.5)
                .overlay {
                    Ellipse()
                        .stroke(Color(red: 0.306, green: 0.302, blue: 0.302), lineWidth: 1)
                }
                
                Spacer().frame(height: 6)
                
//MARK: - Location button
                Button {
                    print("Location")
                } label: {
                    HStack {
                        Text("Location")
                            .font(.custom("Poppins", size: 11))
                            .kerning(-0.5)
                            .foregroundColor(Color(red: 0.502, green: 0.502, blue: 0.502))
                            .ignoresSafeArea()
                        Spacer().frame(width: 3)
                        Image("chevronDownPic")
                            .resizable()
                            .frame(width: 8, height: 5)
                            .foregroundColor(.black)
                    }
                }
            }.offset(x: -22, y:10)
        }
        .padding(.horizontal, 15)
        .padding(.top, -5)
    }
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar(userImageData: nil)
    }
}
