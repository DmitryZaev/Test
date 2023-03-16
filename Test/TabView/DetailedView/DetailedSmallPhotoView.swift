//
//  DetailedSmallPhotoView.swift
//  Test
//
//  Created by Dmitry Victorovich on 15.03.2023.
//

import SwiftUI

struct DetailedSmallPhotoView: View {
    
    @Binding var selected: Int
    let imageUrls: [String]

    var body: some View {
        HStack(spacing: 4.5) {
            ForEach(0..<imageUrls.count, id: \.self) { index in
                ImageFrom(imageUrlString: imageUrls[index])
                    .frame(width: index == selected ? 83 : 65,
                           height: index == selected ? 45 : 37)
                    .cornerRadius(5)
                    .shadow(radius: index == selected ? 4 : 0,
                            y: index == selected ? 4 : 0)
                    .offset(y: index == selected ? -4 : 0)
                    .onTapGesture {
                        withAnimation(.default) {
                            selected = index
                        }
                    }
            }
        }
        .frame(height: 57)
    }
}

struct DetailedSmallPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedSmallPhotoView(selected: .constant(1), imageUrls: ["","",""])
    }
}
