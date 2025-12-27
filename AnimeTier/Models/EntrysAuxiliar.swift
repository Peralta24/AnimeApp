//
//  EntrysAuxiliar.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 02/12/25.
//

import Foundation
import SwiftData

// MARK: - Modelos de Base de Datos (Limpios de Codable)

@Model
final class AnimeImages {
    var jpg: ImageURL
    
    init(jpg: ImageURL) {
        self.jpg = jpg
    }
}

@Model
final class ImageURL {
    var imageUrl: String
    var largeImageUrl: String?
    var smallImageUrl: String?
    
    init(imageUrl: String, largeImageUrl: String? = nil, smallImageUrl: String? = nil) {
        self.imageUrl = imageUrl
        self.largeImageUrl = largeImageUrl
        self.smallImageUrl = smallImageUrl
    }
}

@Model
final class Genre {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

struct AnimeTrailer: Codable {
    var youtubeId: String?
    var url: String?
    var embedUrl: String?
    
    init(youtubeId: String? = nil, url: String? = nil, embedUrl: String? = nil) {
        self.youtubeId = youtubeId
        self.url = url
        self.embedUrl = embedUrl
    }
}

struct Pagination {
    let lastVisiblePage: Int
    let hasNextPage: Bool
}

enum TipoColeccion {
    case favorito
    case verMasTarde
    case meGusta
}

// MARK: - Extensiones Mapper (DTO -> Modelo)

extension AnimeImages {
    convenience init(from dto: AnimeImagesDTO) {
        self.init(jpg: ImageURL(from: dto.jpg))
    }
}

extension ImageURL {
    convenience init(from dto: ImageURLDTO) {
        self.init(
            imageUrl: dto.image_url,
            largeImageUrl: dto.large_image_url,
            smallImageUrl: dto.small_image_url
        )
    }
}

extension Genre {
    convenience init(from dto: GenreDTO) {
        self.init(id: dto.mal_id, name: dto.name)
    }
}

extension AnimeTrailer {
    init(from dto: AnimeTrailerDTO) {
        self.init(
            youtubeId: dto.youtube_id,
            url: dto.url,
            embedUrl: dto.embed_url
        )
    }
}
