//
//  HomeView.swift
//  Test
//
//  Created by Dmitry Victorovich on 11.03.2023.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ZStack {
                    Color(red: 0.98, green: 0.976, blue: 1).ignoresSafeArea()
                    
                    VStack {
//MARK: - Navigation Bar
                        HomeNavigationBar(userImageData: viewModel.userImageData)
//MARK: - Search
                        SearchView(viewModel: viewModel.searchViewModel)
                            .padding(.horizontal, 56)
                            .padding(.top, 2)
                            .zIndex(1)
                        
                        Spacer().frame(height: 17)
//MARK: - Categories
                        HomeCategoriesView(viewWidth: proxy.size.width)
//MARK: - Scroll with blocks
                        ScrollView(.vertical, showsIndicators: false) {
                            Spacer().frame(height: 20)
                            if viewModel.latestLoaded && viewModel.flashSalesLoaded {
                                VStack(spacing: 15) {
                                    BlockView(block: .latest,
                                              items: viewModel.latestArray,
                                              detailedVM: viewModel.detailedViewModel)
                                    
                                    BlockView(block: .flashSale,
                                              items: viewModel.flashSalesArray,
                                              detailedVM: viewModel.detailedViewModel)
                                    
                                    BlockView(block: .brands,
                                              items: viewModel.latestArray.reversed(),
                                              detailedVM: viewModel.detailedViewModel)
                                }
                            } else {
//MARK: - ProgressView while wait
                                ProgressView()
                                    .scaleEffect(2)
                                    .padding()
                                    .offset(y: 200)
                            }
                            Spacer(minLength: 60)
                        }
                        .scrollDismissesKeyboard(.immediately)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            if viewModel.latestArray.isEmpty ||
                viewModel.flashSalesArray.isEmpty {
                viewModel.getData()
            }
        }
        .onDisappear {
            viewModel.clearCancellable()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(searchViewModel: SearchViewModel(),
                                          detailedViewModel: DetailedViewModel()))
    }
}
