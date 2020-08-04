//
//  MainScreenView.swift
//  SwiftEnglish
//
//  Created by Дмитрий on 04.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject var network: NetworkManager
    
    var body: some View {
        ZStack{
            VStack{
                Text("Main View!")
                Button(action: {self.network.logOut()}){
                    Text("LogOut")
                        .padding()
                        .foregroundColor(.red)
                }
                .background(Capsule().stroke(lineWidth: 1).foregroundColor(.red))
                .padding()
            }
        }
        
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(network: NetworkManager())
    }
}
