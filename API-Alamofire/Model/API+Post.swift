//
//  API+Post.swift
//  API-Alamofire
//
//  Created by Reserveit Support on 27/3/23.
//

import Foundation

// MARK: - Post
struct PostModel: Codable {
    let roll: Int?
    let name: String?
    let email: String?
    let password: String?
    
    enum CodingKeys: String, CodingKey {
        case roll = "Roll"
        case name = "Name"
        case email = "Email"
        case password = "Password"
    }
}

struct LoginPostModel: Codable {
    let email: String?
    let password: String?
    
    init(email: String?, password: String?) {
        self.email = email
        self.password = password
    }
}



