//
//  AnimeEntry.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 02/12/25.
//

import Foundation

struct AnimeEntry: Identifiable, Codable {
    let id: Int
    let url: String
    let images: AnimeImages
    let title: String
    let titleEnglish: String?
    let type: String?
    let episodes: Int?
    let status: String?
    let score: Double?
    let synopsis: String?
    let year: Int?
    let genres: [Genre]?
    let popularity: Int?
    
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
    }
    
    static let example = AnimeEntry(
        id: 1,
        url: "https://myanimelist.net/anime/1",
        images: AnimeImages(
            jpg: ImageURL(
                imageUrl: "https://cdn.example.com/anime/example-small.jpg",
                largeImageUrl: "https://cdn.example.com/anime/example-large.jpg"
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
        genres: [Genre(id: 2, name: "nose")],
        popularity: 2
    )}
