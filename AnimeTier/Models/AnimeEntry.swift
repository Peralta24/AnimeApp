//
//  AnimeEntry.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 02/12/25.
//

import Foundation
import SwiftData

@Model
final class AnimeEntry: Codable {
    var id: Int
    var url: String
    var images: AnimeImages
    var title: String
    var titleEnglish: String?
    var type: String?
    var episodes: Int?
    var status: String?
    var score: Double?
    var synopsis: String?
    var year: Int?
    var genres: [Genre]?
    var popularity: Int?
    var trailer: AnimeTrailer?
    
    enum CodingKeys: String, CodingKey {
        case id = "mal_id"
        case url
        case images
        case title
        case titleEnglish = "title_english"
        case type
        case episodes
        case status
        case score
        case synopsis
        case year
        case genres
        case popularity
        case trailer
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.url = try container.decode(String.self, forKey: .url)
        self.images = try container.decode(AnimeImages.self, forKey: .images)
        self.title = try container.decode(String.self, forKey: .title)
        self.titleEnglish = try container.decodeIfPresent(String.self, forKey: .titleEnglish)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.episodes = try container.decodeIfPresent(Int.self, forKey: .episodes)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.score = try container.decodeIfPresent(Double.self, forKey: .score)
        self.synopsis = try container.decodeIfPresent(String.self, forKey: .synopsis)
        self.year = try container.decodeIfPresent(Int.self, forKey: .year)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        self.popularity = try container.decodeIfPresent(Int.self, forKey: .popularity)
        self.trailer = try container.decodeIfPresent(AnimeTrailer.self, forKey: .trailer)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
        try container.encode(images, forKey: .images)
        try container.encode(title, forKey: .title)
        try container.encode(titleEnglish ?? "", forKey: .titleEnglish)
        try container.encode(type ?? "", forKey: .type)
        try container.encode(episodes ?? 0, forKey: .episodes)
        try container.encode(status ?? "", forKey: .status)
        try container.encode(score ?? 0.0, forKey: .score)
        try container.encode(synopsis ?? "", forKey: .synopsis)
        try container.encode(year ?? 0, forKey: .year)
        if let genres = genres {
            try container.encode(genres, forKey: .genres)
        } else {
            try container.encodeNil(forKey: .genres)
        }
        try container.encode(popularity ?? 0, forKey: .popularity)
        try container.encodeIfPresent(trailer, forKey: .trailer)
    }
    
    init(id: Int, url: String, images: AnimeImages, title: String, titleEnglish: String?, type: String?, episodes: Int?, status: String?, score: Double?, synopsis: String?, year: Int?, genres: [Genre]?, popularity: Int?,trailer: AnimeTrailer?) {
        self.id = id
        self.url = url
        self.images = images
        self.title = title
        self.titleEnglish = titleEnglish
        self.type = type
        self.episodes = episodes
        self.status = status
        self.score = score
        self.synopsis = synopsis
        self.year = year
        self.genres = genres
        self.popularity = popularity
        self.trailer = trailer
    }
    
    
    static let example = AnimeEntry(
        id: 1,
        url: "https://myanimelist.net/anime/1",
        
        images: AnimeImages(
            imageUrl: "https://cdn.example.com/anime/example-small.jpg",
            largeImageUrl: "https://cdn.example.com/anime/example-large.jpg"
        ),
        
        title: "Ejemplo Anime",
        titleEnglish: "Example Anime",
        type: "TV",
        episodes: 12,
        status: "Finished Airing",
        score: 8.6,
        synopsis: "Este es un anime de ejemplo para usar en tu proyecto.",
        year: 2020,
        genres: [Genre(id: 2, name: "nose")],
        popularity: 2,
        trailer: AnimeTrailer(
            youtubeId: "qig4KOK2R2g",
            url: "https://www.youtube.com/watch?v=qig4KOK2R2g",
            embedUrl: "https://www.youtube.com/embed/qig4KOK2R2g?enablejsapi=1&wmode=opaque&autoplay=1"
        )
    )
}
