//
//  File.swift
//  SwiftEnglish
//
//  Created by Дмитрий on 02.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
    private let serverName = "https://flow-sample.herokuapp.com"
    @Published var textError = ""
    @Published private var token: String{
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(token) {
                UserDefaults.standard.set(encoded, forKey: "Token")
            }
        }
    }
    enum HttpMethods: String{
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case put = "PUT"
    }
    
    enum APIUrls: String{
        case signUp = "/api/passport/sign-up"
        case signIn = "/api/passport/sign-in"
    }
    
    init(){
        if let token = UserDefaults.standard.data(forKey: "Token"){
            let decoder = JSONDecoder()
            if let decodeItem = try? decoder.decode(String.self, from: token){
                self.token = decodeItem
                return
            }
        }
        self.token = ""
    }
    
    func userIsNotLogin() -> Bool{
        return token.isEmpty
    }
    
    func logOut(){
        token = ""
    }
    
    func signUpOrIn<T:Codable>(userInfo: T, apiUrl: APIUrls, completion: @escaping (UserResponce?) -> Void) {
        guard let encoded = try? JSONEncoder().encode(userInfo) else {
            textError = "Failed to encode User Information"
            return
        }
        
        guard let url = URL(string: serverName + apiUrl.rawValue) else {
            self.textError = "Failed get URL from String"
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = HttpMethods.post.rawValue
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.textError = "No data in response: \(error?.localizedDescription ?? "Unknown error")."
                completion(nil)
                return
            }
            if let userToken = try? JSONDecoder().decode(UserResponce.self, from: data) {
                self.token = userToken.token
                completion(userToken)
            } else if let errUser = try? JSONDecoder().decode(Error.self, from: data) {
                self.textError = errUser.err
                completion(nil)
                return
            } else {
                self.textError = "Invalid response from server"
                completion(nil)
                return
            }
        }.resume()
    }
}

