//
//  DetailedBigPhotoView.swift
//  Test
//
//  Created by Dmitry Victorovich on 15.03.2023.
//

import SwiftUI

struct DetailedBigPhotoView: View {
    
    @Binding var selected: Int
    let imageUrls: [String]?
    let imageSize: CGSize
    let buttonsBlockSize: CGSize
    let buttonsBlockOffset: CGSize
    
    var body: some View {
//MARK: - Image
        ZStack {
            TabView(selection: Binding(get: {
                selected
            }, set: { newValue in
                withAnimation(.default) {
                    selected = newValue
                }
            })) {
                if let imageUrls {
                    ForEach(0..<imageUrls.count, id: \.self) { index in
                        ImageFrom(imageUrlString: imageUrls[index])
                            .tag(index)
                    }
                }
            }
            .background(.white)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: imageSize.width)
            .cornerRadius(10)
            .padding(.leading, -5)
            
//MARK: - Favorites/Share buttons
            VStack {
                Spacer()
                
                Button {
                    print("to favorites")
                } label: {
                    Image("favorites1Pic")
                        .resizable()
                        .frame(width: 17, height: 15)
                }
                
                Spacer()
                
                Rectangle()
                    .frame(width: 12, height: 1)
                
                Spacer()
                
                Button {
                    print("share")
                } label: {
                    Image("sharePic")
                        .resizable()
                        .frame(width: 16, height: 18)
                }
                
                Spacer()
            }
            .frame(width: buttonsBlockSize.width,
                   height: buttonsBlockSize.height)
            .background(Color(red: 0.898, green: 0.914, blue: 0.937))
            .foregroundColor(Color(red: 0.329, green: 0.333, blue: 0.537))
            .cornerRadius(15)
            .offset(buttonsBlockOffset)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: imageSize.height)
    }
}

struct DetailedBigPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedBigPhotoView(selected: .constant(0),
                             imageUrls: [""],
                             imageSize: CGSize(width: 328, height: 279),
                             buttonsBlockSize: CGSize(width: 42, height: 95),
                             buttonsBlockOffset: CGSize(width: 156, height: 64))
    }
}
