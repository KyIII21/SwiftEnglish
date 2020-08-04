//
//  User.swift
//  SwiftEnglish
//
//  Created by Дмитрий on 02.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation

struct UserForSignUp: Codable{
    var email: String
    var password: String
    var lang: Lang
    
    init(){
        email = ""
        password = ""
        lang = Lang()
    }
}

struct Lang: Codable{
    var learn: String
    var know: String
    
    init(){
        learn = ""
        know = ""
    }
}

struct UserForLogin: Codable {
    var email: String
    var password: String
    
    init() {
        email = ""
        password = ""
    }
}

struct UserResponce: Codable{
    var user: inUserResponce
    var token: String
    
    struct inUserResponce: Codable{
        var email: String
        var lang: Lang
        var id: String
        
    }
}

struct Error: Codable {
    var err: String
}
