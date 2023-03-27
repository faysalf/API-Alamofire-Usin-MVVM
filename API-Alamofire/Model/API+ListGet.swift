//
//  API+ListGet.swift
//  API-Alamofire
//
//  Created by Reserveit Support on 27/3/23.
//

import Foundation

// MARK: - ListGetModel
struct ListGetModel: Codable {
    let page, perPage, total, totalPages: Int
    let data: [Datum]
    let support: ListSupport

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

struct Datum: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct ListSupport: Codable {
    let url: String
    let text: String
}
