//
//  ProfileListView.swift
//  Test
//
//  Created by Dmitry Victorovich on 11.03.2023.
//

import SwiftUI

struct ProfileListView: View {
    
    @Binding var logoutPressed: Bool
    let balance: Double
    
    var body: some View {
        VStack(spacing: 23) {
            ForEach(ListItem.allCases, id: \.rawValue) {
                createItemFor($0)
            }
        }
    }

//MARK: - Item Builder
    @ViewBuilder fileprivate func createItemFor(_ item: ListItem) -> some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(Color(red: 0.933, green: 0.937, blue: 0.957))
                Image(item.imageName)
                    .resizable()
                    .frame(width: item.imageSize.width,
                           height: item.imageSize.height)
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 40)
            
            Text(item.rawValue)
                .font(.custom("Montserrat", size: 15))
            
            Spacer()
            
            if item.chevron {
                Image("chevronRightPic")
                    .resizable()
                    .frame(width: 8.5, height: 13)
            } else if item == .balance {
                Text("$ " + String(format: "%.0f", balance))
                    .font(.custom("Montserrat", size: 15))
            }
        }
        .frame(height: 40)
        .foregroundColor(Color(red: 0.016, green: 0.016, blue: 0.008))
        .onTapGesture {
            switch item {
            case .logOut:
                logoutPressed.toggle()
            default: break
            }
        }
    }
}

fileprivate enum ListItem: String, CaseIterable {
    case tradeStore =      "Trade store"
    case paymentMethod =   "Payment method"
    case balance =         "Balance"
    case tradeHistory =    "Trade history"
    case restorePurchase = "Restore Purchase"
    case help =            "Help"
    case logOut =          "Log out"
    
    var imageName: String {
        switch self {
        case .tradeStore,
             .paymentMethod,
             .balance ,
             .tradeHistory:    return "cardPic"
        case .restorePurchase: return "restorePic"
        case .help:            return "helpPic"
        case .logOut:          return "logOutPic"
        }
    }
    
    var imageSize: CGSize {
        switch self {
        case .tradeStore,
             .paymentMethod,
             .balance ,
             .tradeHistory:    return CGSize(width: 24, height: 18)
        case .restorePurchase: return CGSize(width: 24, height: 20)
        case .help:            return CGSize(width: 22, height: 22)
        case .logOut:          return CGSize(width: 20, height: 20)
        }
    }
    
    var chevron: Bool {
        switch self {
        case .tradeStore, .paymentMethod, .tradeHistory, .restorePurchase:
            return true
        case .balance, .help, .logOut:
            return false
        }
    }
}

struct ProfileListView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileListView(logoutPressed: .constant(false),
                 balance: 0)
    }
}
