//
//  NatureModel.swift
//  BitenTechincalTask
//
//  Created by Александр Кузьминов on 13.01.24.
//

import Foundation

struct NatureElement: Codable {
    let id: Int
    let image: String
    let categories: Categories
    let name, description: String
    let documentation: String?
    let fields: [Field]
}
struct Categories: Codable {
    let id: Int
    let icon, image, name: String
}
struct Field: Codable {
    let typesID: Int
    let type: TypeEnum
    let name, value: String
    let image: String?
    let flags: Flags
    let show, group: Int

    enum CodingKeys: String, CodingKey {
        case typesID = "types_id"
        case type, name, value, image, flags, show, group
    }
}

struct Flags: Codable {
    let html, noValue, noName, noImage: Int
    let noWrap, noWrapName, system: Int

    enum CodingKeys: String, CodingKey {
        case html
        case noValue = "no_value"
        case noName = "no_name"
        case noImage = "no_image"
        case noWrap = "no_wrap"
        case noWrapName = "no_wrap_name"
        case system
    }
}
enum TypeEnum: String, Codable {
    case image = "image"
    case list = "list"
    case text = "text"
}

