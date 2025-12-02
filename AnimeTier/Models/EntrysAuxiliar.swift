//
//  EntrysAuxiliar.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 02/12/25.
//

import Foundation

struct AnimeImages: Codable {
    let jpg: ImageURL
}

struct ImageURL: Codable {
    let imageUrl: String
    let largeImageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case largeImageUrl = "large_image_url"
    }
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case name
    }
}

struct Pagination: Codable {
    let lastVisiblePage: Int
    let hasNextPage: Bool
    
    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
    }
}
