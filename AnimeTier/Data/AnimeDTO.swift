//
//  AnimeDTO.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 26/12/25.
//

import Foundation

// MARK: - Respuesta Principal
struct AnimeResponseDTO: Codable {
    let data: [AnimeDTO]
    // let pagination: PaginationDTO? // Puedes agregarlo si vas a usar paginación luego
}

// MARK: - Objeto Anime (DTO)
struct AnimeDTO: Codable {
    let mal_id: Int
    let url: String
    let images: AnimeImagesDTO // Corregido: La API devuelve "images"
    let title: String
    let title_english: String?
    let type: String?
    let episodes: Int?
    let status: String?
    let score: Double?
    let synopsis: String?
    let year: Int?
    let popularity: Int?
    let genres: [GenreDTO]?
    let trailer: AnimeTrailerDTO?
}

// MARK: - Imágenes
struct AnimeImagesDTO: Codable {
    let jpg: ImageURLDTO
}

struct ImageURLDTO: Codable {
    let image_url: String
    let small_image_url: String?
    let large_image_url: String?
}

// MARK: - Géneros
struct GenreDTO: Codable {
    let mal_id: Int
    let name: String
    let type: String?
    let url: String?
}

// MARK: - Trailer
struct AnimeTrailerDTO: Codable {
    let youtube_id: String?
    let url: String?
    let embed_url: String?
}
