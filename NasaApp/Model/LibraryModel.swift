//
//  LibraryModel.swift
//  NasaApp
//
//  Created by Marta Michelle Caliendo on 25/03/23.
//

import Foundation

// MARK: - LibraryModel
struct LibraryModel: Codable {
    var collection: Collection
}

// MARK: - Collection
struct Collection: Codable {
    var items: [Item]
    let links: [CollectionLink]
}

// MARK: - Item
struct Item: Codable, Identifiable {
    var id: String {
        UUID().uuidString
    }
    let data: [Datum]?
    let links: [ItemLink]
}

// MARK: - Datum
struct Datum: Codable {
    let title: String
    let dateCreated: String
    let keywords: [String]
    let description508: String?
    let description: String

    enum CodingKeys: String, CodingKey {
        case title
        case dateCreated = "date_created"
        case keywords
        case description508 = "description_508"
        case description
    }
}


// MARK: - ItemLink
struct ItemLink: Codable {
    let href: String
    let imageData: Data?
}


// MARK: - CollectionLink
struct CollectionLink: Codable {
    let href: String //image
}

//// MARK: - Welcome
//struct Welcome: Codable {
//    let collection: Collection
//}
//
//// MARK: - Collection
//struct Collection: Codable {
//    let version: String
//    let href: String
//    let items: [Item]
//    let metadata: Metadata
//}
//
//// MARK: - Item
//struct Item: Codable {
//    let href: String
//    let data: [Datum]
//    let links: [Link]
//}
//
//// MARK: - Datum
//struct Datum: Codable {
//    let center, title: String
//    let keywords: [String]
//    let nasaID: String
//    let dateCreated: Date
//    let mediaType, description: String
//
//    enum CodingKeys: String, CodingKey {
//        case center, title, keywords
//        case nasaID = "nasa_id"
//        case dateCreated = "date_created"
//        case mediaType = "media_type"
//        case description
//    }
//}
//
//// MARK: - Link
//struct Link: Codable {
//    let href: String
//    let rel, render: String
//}
//
//// MARK: - Metadata
//struct Metadata: Codable {
//    let totalHits: Int
//
//    enum CodingKeys: String, CodingKey {
//        case totalHits = "total_hits"
//    }
//}
