//
//  LoginView.swift
//  SwiftEnglish
//
//  Created by Дмитрий on 02.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation
import SwiftUI
import FacebookLogin


class UserLoginManager: ObservableObject {
    let loginManager = LoginManager()
    func facebookLogin() {
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        let fbDetails = result as! NSDictionary
                        print(fbDetails)
                    }
                })
            }
        }
    }
}

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var againPassword = ""
    
    @ObservedObject var fbmanager = UserLoginManager()

   
    func signUpButton(){
       presentationMode.wrappedValue.dismiss()
    }
   
    var body: some View {
        NavigationView{
            VStack{
                TextField("email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {}){
                    Text("SIGN IN")
                        .padding(10)
                        .foregroundColor(.black)
                }
                .background(Capsule().stroke(lineWidth: 1))
                .padding()
                Button(action: {self.fbmanager.facebookLogin()}){
                    //Image(systemName: "facebook")
                    Text("Log in with FaceBook")
                       .padding(10)
                       //.foregroundColor(self.backgroundColor)
                }
                .background(Capsule().stroke(lineWidth: 1).foregroundColor(.blue))
                .padding()

                Spacer()
            }
           .padding()
           .navigationBarTitle("Sign In")
           .navigationBarItems(trailing: Button(action:     {self.presentationMode.wrappedValue.dismiss()}){
                Text("Close")
                    .foregroundColor(.red)
                })
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
