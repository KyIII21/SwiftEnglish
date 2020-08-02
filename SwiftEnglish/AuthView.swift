//
//  AuthView.swift
//  SwiftEnglish
//
//  Created by Дмитрий on 02.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct AuthView: View {
    private let backgroundColor = Color(red: 0.07, green: 0.07, blue: 0.07)
    private let mainColor = Color(red: 0.38, green: 0.85, blue: 0.98)
    @State private var showingLoginSheet = false
    @State private var showingSignUpSheet = false
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                self.backgroundColor
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(minWidth: 30, idealWidth: 70, maxWidth: 180, minHeight: 60, idealHeight: 120, maxHeight: 240, alignment: .center)
                        .padding()
                    Text("Proper way to learn languages")
                        .font(.title)
                        .foregroundColor(self.mainColor)
                    HStack{
                        Button(action: {self.showingLoginSheet.toggle()}){
                            Text("LOGIN")
                                .padding(10)
                        }
                        .background(Capsule().stroke(lineWidth: 2))
                        .foregroundColor(self.mainColor)
                        .sheet(isPresented: self.$showingLoginSheet){
                            //AddBookView().environment(\.managedObjectContext, self.moc)
                            LoginView()
                        }
                        Button(action: {self.showingSignUpSheet.toggle()}){
                            Text("SIGN UP")
                                .padding(10)
                                .foregroundColor(self.backgroundColor)
                        }
                        .background(Capsule().foregroundColor(self.mainColor)
                            )
                        .padding(.leading)
                        .sheet(isPresented: self.$showingSignUpSheet){
                            //AddBookView().environment(\.managedObjectContext, self.moc)
                            SignUpView()
                        }
                    }
                    .padding()
                    
                }
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
