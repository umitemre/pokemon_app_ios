//
//  CardsResult.swift
//  Pokemon App
//
//  Created by Emre Aydin on 5.10.2023.
//

import Foundation

// MARK: CardResult
struct CardsResult: Codable {
    let cards: [Card]?
}

// MARK: CardResult
struct CardResult: Codable {
    let card: Card?
}

// MARK: Card
struct Card: Codable {
    let id: String?
    let name: String?
    let artist: String?
    let imageURL: String?
    let imageURLHiRes: String?
    let hp: String?

    // MARK: Init
    init(
        id: String? = nil,
        name: String? = nil,
        artist: String? = nil,
        imageURL: String? = nil,
        imageURLHiRes: String? = nil,
        hp: String? = nil
    ) {
        self.id = id
        self.name = name
        self.artist = artist
        self.imageURL = imageURL
        self.imageURLHiRes = imageURLHiRes
        self.hp = hp
    }
    
    // MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case imageURL = "imageUrl"
        case imageURLHiRes = "imageUrlHiRes"
        case hp
    }
}
