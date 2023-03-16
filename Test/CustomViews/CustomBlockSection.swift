//
//  CustomBlockSection.swift
//  Test
//
//  Created by Dmitry Victorovich on 12.03.2023.
//

import SwiftUI

struct CustomBlockSection<Content: View>: View {
    
    let title: String
    private var content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack {
//MARK: - BlockHeader
            HStack {
                Text(title)
                    .font(.custom("Poppins", size: 16))
                    .foregroundColor(Color(red: 0.016, green: 0.016, blue: 0.008))
                
                Spacer()
                
                Button {
                    print("View all \(title)")
                } label: {
                    Text("View all")
                        .font(.custom("Poppins", size: 10))
                        .foregroundColor(Color(red: 0.502, green: 0.502, blue: 0.502))
                }

            }
            .padding(.horizontal, 12)
            
            Spacer().frame(height: 5)

//MARK: - BlockBody
            ScrollView(.horizontal,showsIndicators: false) {
                content
            }
        }
        .ignoresSafeArea()
    }
}

struct CustomBlockSection_Previews: PreviewProvider {
    static var previews: some View {
        CustomBlockSection(title: "Latest") {
            Rectangle()
                .frame(width: 100, height: 100)
        }
    }
}
