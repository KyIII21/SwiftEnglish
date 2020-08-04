//
//  SignUpView.swift
//  SwiftEnglish
//
//  Created by Дмитрий on 02.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var network: NetworkManager
    @Environment(\.presentationMode) var presentationMode
    @State private var learnLang = 0
    @State private var knowLang = 1
    private let langs = ["EN", "RU", "ES"]
    @State private var againPassword = ""
    @State private var user = UserForSignUp()
    @State var showingError = false
 
    func checkDisableSignUpButton() -> Bool{
        if user.email.count < 6 || user.password.count < 7{
            return true
        }
        if !user.email.contains("@") || !user.email.contains("."){
            return true
        }
        if user.password != againPassword{
            return true
        }
        return false
    }
    
    func signUpButton(){
        user.lang.know = langs[knowLang].lowercased()
        user.lang.learn = langs[learnLang].lowercased()
        
        network.signUpOrIn(userInfo: user, apiUrl: .signUp) { userResponce in
            if userResponce != nil {
                //if user signUp
                DispatchQueue.main.async {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }else{
                self.showingError.toggle()
            }
        }
        
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
                TextField("email", text: $user.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("password", text: $user.password)
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
            .alert(isPresented: $showingError){
                Alert(title: Text("Error SignUp"), message: Text("\(network.textError)"), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(network: NetworkManager())
    }
}
