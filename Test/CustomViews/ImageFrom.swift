//
//  ImageFrom.swift
//  Test
//
//  Created by Dmitry Victorovich on 13.03.2023.
//

import SwiftUI

struct ImageFrom: View {

    let imageUrlString: String

    var body: some View {
        AsyncImage(url: URL(string: imageUrlString)) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Rectangle()
                        .scaledToFill()
                        .foregroundColor(.white)
                    ProgressView()
                }
            case .failure(_):
                Rectangle()
                    .scaledToFill()
                    .foregroundColor(.white)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            @unknown default:
                fatalError()
            }
        }
    }
}


struct ImageFrom_Previews: PreviewProvider {
    static var previews: some View {
        ImageFrom(imageUrlString: "")
    }
}
