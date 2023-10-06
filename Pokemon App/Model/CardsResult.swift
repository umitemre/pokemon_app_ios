//
//  CardsResult.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation

struct CardsResult: Codable {
    let cards: [Card]?
}

struct Card: Codable {
    let id: String?
    let name: String?
    let artist: String?
    let imageURL: String?
    let imageURLHiRes: String?
    let hp: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case imageURL = "imageUrl"
        case imageURLHiRes = "imageUrlHiRes"
        case hp
    }
}
