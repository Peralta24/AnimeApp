//
//  EntrysAuxiliar.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 02/12/25.
//

import Foundation
import SwiftData
@Model
final class AnimeImages: Codable, Hashable {
    var jpg: ImageURL
    
    enum CodingKeys: String, CodingKey {
        case jpg
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.jpg = try container.decode(ImageURL.self, forKey: .jpg)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(jpg, forKey: .jpg)
    }
    init (imageUrl: String, largeImageUrl: String?) {
        self.jpg = .init(imageUrl: imageUrl, largeImageUrl: largeImageUrl)
    }
}

@Model
final class ImageURL: Codable, Hashable {
    var imageUrl: String
    var largeImageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case largeImageUrl = "large_image_url"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.largeImageUrl = try container.decodeIfPresent(String.self, forKey: .largeImageUrl)
    }
        
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(largeImageUrl, forKey: .largeImageUrl)
    }
    
    init(imageUrl: String, largeImageUrl: String?) {
        self.imageUrl = imageUrl
        self.largeImageUrl = largeImageUrl
    }
}

@Model
final class Genre: Codable, Hashable {     var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
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

struct AnimeTrailer: Codable {
    var youtubeId: String?
    var url: String?
    var embedUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case youtubeId = "youtube_id"
        case url
        case embedUrl = "embed_url"
    }
    
    
}
