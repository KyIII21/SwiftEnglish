//
//  SignUpView.swift
//  SwiftEnglish
//
//  Created by Дмитрий on 02.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var learnLang = 0
    @State private var knowLang = 1
    private let langs = ["EN", "RU", "ES"]
    @State private var email = ""
    @State private var password = ""
    @State private var againPassword = ""
 
    func checkDisableSignUpButton() -> Bool{
        if email.count < 6 || password.count < 7{
            return true
        }
        if !email.contains("@") || !email.contains("."){
            return true
        }
        if password != againPassword{
            return true
        }
        return false
    }
    
    func signUpButton(){
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    VStack{
                        Text("Learn")
                        Picker(selection: $learnLang, label: Text("Learn")){
                            ForEach(0..<langs.count) {
                               Text(self.langs[$0])
                           }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Spacer()
                    VStack{
                        Text("Know")
                        Picker(selection: $knowLang, label: Text("Know")){
                            ForEach(0..<langs.count) {
                               Text(self.langs[$0])
                           }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                TextField("email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("again password", text: $againPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {self.signUpButton()}){
                    Text("SIGN UP")
                        .padding(10)
                        .foregroundColor(.black)
                        .opacity(self.checkDisableSignUpButton() ? 0.5 : 1)
                }
                .background(Capsule().stroke(lineWidth: 1).opacity(self.checkDisableSignUpButton() ? 0.5 : 1))
                .padding()
                .disabled(self.checkDisableSignUpButton())
                
                Spacer()
            }
        .padding()
        .navigationBarTitle("Sign Up")
        .navigationBarItems(trailing: Button(action: {self.presentationMode.wrappedValue.dismiss()}){
            Text("Close")
                .foregroundColor(.red)
            })
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
