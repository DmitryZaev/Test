//
//  CustomTabBarView.swift
//  Test
//
//  Created by Dmitry Victorovich on 11.03.2023.
//

import SwiftUI

struct CustomTabBarView<Content: View>: View {
    
    @Binding var currentTab: TabItem?
    private var content: Content
    
    init(currentTab: Binding<TabItem?>, @ViewBuilder content: () -> Content) {
        _currentTab = currentTab
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
                .background(.clear)

//MARK: - Custom tabBar View
            VStack {
                Spacer()
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.white)                    
                    HStack {
                        GeometryReader { proxy in
                            ForEach(TabItem.allCases, id: \.imageName) {
                                createTabFor(item: $0, fieldSize: proxy.size)
                            }
                        }
                    }
                    .frame(height: 63)
                }
                .frame(height: 87)
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
//MARK: - Tab Items builder
    @ViewBuilder func createTabFor(item: TabItem, fieldSize: CGSize) -> some View {
        ZStack {
            if currentTab == item {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color(red: 0.933, green: 0.937, blue: 0.957))
            }
            
            Image(item.imageName)
                .resizable()
                .frame(width: item == .favorites ? 20 : 17, height: 17)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(currentTab == item ? Color(red: 0.451, green: 0.447, blue: 0.592) : Color(red: 0.568, green: 0.568, blue: 0.568))
                .onTapGesture {
                    currentTab = item
                }
        }
        .position(x: fieldSize.width / 10 + (fieldSize.width / 5) * item.position,
                  y: fieldSize.height / 2)
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView(currentTab: .constant(.home)){}
    }
}
