//
//  DetailedTextView.swift
//  Test
//
//  Created by Dmitry Victorovich on 15.03.2023.
//

import SwiftUI

struct DetailedTextView: View {
    
    let name: String
    let description: String?
    let rating: String?
    let numberOfReviews: String?
    let priceString: String
    let viewWidth: CGFloat
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(spacing: 16) {
//MARK: - Name text
                Text(name)
                    .font(.custom("Poppins", size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 0.086, green: 0.094, blue: 0.149))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
//MARK: - Description text
                if let description {
                    Text(description)
                        .font(.custom("Poppins", size: 9))
                        .foregroundColor(Color(red: 0.502, green: 0.502, blue: 0.502))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
//MARK: - Rating & Reviews
                if let rating,
                   let numberOfReviews {
                    HStack(spacing: 3){
                        Image("starPic")
                            .resizable()
                            .frame(width: 12, height: 11.5)
                            .foregroundColor(Color(red: 0.965, green: 0.753, blue: 0.259))
                        
                        Text(rating)
                            .font(.custom("Poppins", size: 9))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.086, green: 0.094, blue: 0.149))
                        
                        Text("(\(numberOfReviews) reviews)")
                            .font(.custom("Poppins", size: 9))
                            .foregroundColor(Color(red: 0.502, green: 0.502, blue: 0.502))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(width: viewWidth * 0.6)
            
//MARK: - Price
            Text("$ \(priceString)")
                .font(.custom("Poppins", size: 13))
                .fontWeight(.semibold)
                .foregroundColor(Color(red: 0.086, green: 0.094, blue: 0.149))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct DetailedTextView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedTextView(name: "New Balance Snickers",
                         description: "Gdsklfjsdklj sdlkjdflkgdf dlfgjdlkfgdfkl dlkfghdfklghdfkl dflkgdfklghfdlk kdfgkldfgh",
                         rating: "4.2",
                         numberOfReviews: "3000",
                         priceString: "22,50",
                         viewWidth: 375)
    }
}
