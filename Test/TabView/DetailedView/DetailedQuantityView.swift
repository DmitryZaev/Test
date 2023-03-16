//
//  DetailedQuantityView.swift
//  Test
//
//  Created by Dmitry Victorovich on 15.03.2023.
//

import SwiftUI

struct DetailedQuantityView: View {
    
    @Binding var addToCartPressed: Bool
    @Binding var quantity: Int
    let price: Double
    let summ: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(red: 0.094, green: 0.09, blue: 0.149))
            
            HStack(alignment: .bottom) {
                VStack {
                    Text("Quantity:")
                        .font(.custom("Poppins", size: 9))
                        .foregroundColor(Color(red: 0.502, green: 0.502, blue: 0.502))
//MARK: - +/- buttons
                    Button {
                        if quantity > 1 {
                            quantity -= 1
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 38, height: 22)
                            .foregroundColor(Color(red: 0.306, green: 0.333, blue: 0.843))
                            .overlay {
                                Image("minusPic")
                                    .resizable()
                                    .frame(width: 8, height: 2)
                                    .foregroundColor(.white)
                            }
                    }
                }.offset(y: -3)
                
                Spacer().frame(width: 21)
                
                Button {
                    quantity += 1
                } label: {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 38, height: 22)
                        .foregroundColor(Color(red: 0.306, green: 0.333, blue: 0.843))
                        .overlay {
                            Image("plus1Pic")
                                .resizable()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.white)
                        }
                }
                .offset(y: -3)
                
                Spacer()

//MARK: - Add to cart button
                Button {
                    addToCartPressed.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 170, height: 44)
                        .foregroundColor(Color(red: 0.306, green: 0.333, blue: 0.843))
                        .overlay {
                            HStack {
                                Text("$ \(summ)")
                                    .foregroundColor(Color(red: 0.6, green: 0.627, blue: 1))
                                Spacer()
                                Text("ADD TO CART")
                                    .foregroundColor(Color.white)
                            }
                            .padding(.horizontal, 30)
                            .font(.custom("Poppins", size: 9))
                            .fontWeight(.semibold)
                        }
                }
            }
            .padding(.horizontal, 24)
            .offset(y: -45)
        }
        .ignoresSafeArea()
        .frame(height: 174)
    }
}

struct DetailedQuantityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedQuantityView(addToCartPressed: .constant(false),
                             quantity: .constant(1),
                             price: 22.5,
                             summ: "45,00")
    }
}
