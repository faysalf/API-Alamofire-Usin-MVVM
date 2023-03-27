//
//  ViewModel.swift
//  API-Alamofire
//
//  Created by Reserveit Support on 25/3/23.
//

import UIKit

struct UserInfo {
    let img: String
    let id: Int
    let name: String
    
    init(img: String, id: Int, name: String) {
        self.img = img
        self.id = id
        self.name = name
    }
}
