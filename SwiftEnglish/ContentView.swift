//
//  ContentView.swift
//  SwiftEnglish
//
//  Created by Дмитрий on 02.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var network = NetworkManager()
    var body: some View {
        ZStack{
            if network.userIsNotLogin(){
                AuthView(network: network)
            }else{
                MainScreenView(network: network)
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
