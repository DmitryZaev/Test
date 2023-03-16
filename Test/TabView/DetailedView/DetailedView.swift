//
//  DetailedView.swift
//  Test
//
//  Created by Dmitry Victorovich on 14.03.2023.
//

import SwiftUI

struct DetailedView<ViewModel: DetailedViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    @State var selected = 0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color(red: 0.98, green: 0.976, blue: 1).ignoresSafeArea()
                
                VStack {
//MARK: - Big photo (TabView)
                    DetailedBigPhotoView(selected: $selected,
                                         imageUrls: viewModel.imageUrls)
                    
                    Spacer().frame(height: 31)
//MARK: - Small photos
                    DetailedSmallPhotoView(selected: $selected,
                                           imageUrls: viewModel.imageUrls)
                    
                    Spacer().frame(height: 16)
                    
//MARK: - Name, Price, Rating, Reviews, Description
                    DetailedTextView(name: viewModel.name ?? "",
                                     description: viewModel.description,
                                     rating: viewModel.rating,
                                     numberOfReviews: viewModel.numberOfReviews,
                                     priceString: viewModel.priceString,
                                     viewWidth: proxy.size.width)
                    .padding(.horizontal, 24)
//MARK: - Colors
                    DetailedColorsView(colors: viewModel.colors,
                                       selected: 0)
                    .padding(.leading, 24)
                    
                    Spacer()
                    
//MARK: - +/- & AddToCart buttons
                    if let price = viewModel.price {
                        DetailedQuantityView(addToCartPressed: $viewModel.goToCart,
                                             quantity: $viewModel.quantity,
                                             price: price,
                                             summ: viewModel.getSummString())
                        .offset(y: -70)
                    }
                }
                .offset(y:70)
            }
            .navigationBarBackButtonHidden()
//MARK: - Back button
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Image("chevronLeftPic")
                            .resizable()
                            .frame(width: 8, height: 14)
                            .foregroundColor(.black)
                    }
                    
                }
            }
            .onAppear {
                viewModel.getData()
            }
            .onDisappear {
                viewModel.clearCancellable()
            }
        }
        .ignoresSafeArea()
    }
}

struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(viewModel: DetailedViewModel())
    }
}
