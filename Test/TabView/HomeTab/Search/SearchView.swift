//
//  SeachView.swift
//  Test
//
//  Created by Dmitry Victorovich on 14.03.2023.
//

import SwiftUI

struct SearchView<ViewModel: SearchViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @FocusState var searchTextFieldIsActive: Bool
    
    var body: some View {
        ZStack {
//MARK: - Background & Search button
            RoundedRectangle(cornerRadius: 14.5)
                .frame(height: 24)
                .foregroundColor(Color(red: 0.961, green: 0.965, blue: 0.969))
                .overlay(alignment: .trailing) {
                    Button {
                        print("search")
                    } label: {
                        Image("magnifierPic")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color(red: 0.357, green: 0.357, blue: 0.357))
                            .padding(.trailing, 18)
                    }
                }

//MARK: - Search TextField
            TextField("",
                      text: Binding(get: {
                viewModel.searchText
            }, set: { newValue in
                viewModel.searchText = newValue
                viewModel.getData()
            }),
                      prompt: Text("What are you looking for ?").foregroundColor(Color(red: 0.357, green: 0.357, blue: 0.357)))
            .multilineTextAlignment(viewModel.searchText.isEmpty ? .center : .leading)
            .font(.custom("Poppins", size: viewModel.fontSize))
            .foregroundColor(.black)
            .focused($searchTextFieldIsActive)
            .frame(height: 24)
            .padding(.trailing, 28)
            .padding(.leading, 5)
        }
        .background {
//MARK:  - DropDownList
            if !viewModel.dropDownList.isEmpty,
               searchTextFieldIsActive {
                ZStack {
                    RoundedRectangle(cornerRadius: 14.5)
                        .foregroundColor(Color(red: 0.961, green: 0.965, blue: 0.969))
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.dropDownList, id: \.self) { text in
                            Text("  \(text)")
                                .font(.custom("Poppins", size: 10))
                                .foregroundColor(.black)
                                .frame(height: 10)
                                .onTapGesture {
                                    viewModel.select(text: text)
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                    .padding(.top, 24)
                }
                .offset(y: viewModel.getOffsetY())
            }
        }
        .onDisappear {
            viewModel.clearCancellable()
            viewModel.searchText = ""
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
