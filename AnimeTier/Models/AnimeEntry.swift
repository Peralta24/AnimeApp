//
//  AnimeEntry.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 02/12/25.
//

import Foundation
import SwiftData

@Model
final class AnimeEntry {
    @Attribute(.unique) var id: Int
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
    var isFavorite: Bool = false
    var isWatchLater: Bool = false
    var isLiked: Bool = false
    
    init(id: Int, url: String, images: AnimeImages, title: String, titleEnglish: String? = nil, type: String? = nil, episodes: Int? = nil, status: String? = nil, score: Double? = nil, synopsis: String? = nil, year: Int? = nil, genres: [Genre]? = nil, popularity: Int? = nil, trailer: AnimeTrailer? = nil, isFavorite: Bool = false, isWatchLater: Bool = false, isLiked: Bool = false) {
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
        self.isFavorite = isFavorite
        self.isWatchLater = isWatchLater
        self.isLiked = isLiked
    }
    
    static let example = AnimeEntry(
        id: 1,
        url: "https://myanimelist.net/anime/1",
        images: AnimeImages(
            jpg: ImageURL(
                imageUrl: "https://cdn.example.com/anime/example-small.jpg",
                largeImageUrl: "https://cdn.example.com/anime/example-large.jpg",
                smallImageUrl: "https://cdn.example.com/anime/example-small.jpg"
            )
        ),
        title: "Ejemplo Anime",
        titleEnglish: "Example Anime",
        type: "TV",
        episodes: 12,
        status: "Finished Airing",
        score: 8.6,
        synopsis: "Este es un anime de ejemplo para usar en tu proyecto.",
        year: 2020,
        genres: [Genre(id: 2, name: "Aventura")],
        popularity: 2,
        trailer: AnimeTrailer(
            youtubeId: "qig4KOK2R2g",
            url: "https://www.youtube.com/watch?v=qig4KOK2R2g",
            embedUrl: "https://www.youtube.com/embed/qig4KOK2R2g"
        )
    )
}

extension AnimeEntry {
    
    convenience init(from dto: AnimeDTO) {
        self.init(
            id: dto.mal_id,
            url: dto.url,
            images: AnimeImages(from: dto.images),
            title: dto.title,
            titleEnglish: dto.title_english,
            type: dto.type,
            episodes: dto.episodes,
            status: dto.status,
            score: dto.score,
            synopsis: dto.synopsis,
            year: dto.year,
            genres: dto.genres?.map { Genre(from: $0) } ?? [],
            popularity: dto.popularity,
            trailer: dto.trailer != nil ? AnimeTrailer(from: dto.trailer!) : nil
        )
    }
    
    func update(from dto: AnimeDTO) {
        self.score = dto.score
        self.episodes = dto.episodes
        self.status = dto.status
        self.popularity = dto.popularity
        self.synopsis = dto.synopsis
        self.year = dto.year
    }
}
