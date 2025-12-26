//
//  AddAnimeView-ViewModel.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 26/12/25.
//

import Foundation
import SwiftData

@Observable
final class AddAnimeViewModel {
    
    var anime: AnimeEntry

    init(anime: AnimeEntry) {
        self.anime = anime
    }
    
    
    func toogle(_ tipo: TipoColeccion, using context: ModelContext) {
        
        switch tipo {
        case .favorito:
            if anime.isFavorite {
                anime.isFavorite = false
            } else {
                anime.isFavorite = true
            }
        case .verMasTarde:
            if anime.isWatchLater {
                anime.isWatchLater = false
            } else {
                anime.isWatchLater = true
            }
        case .meGusta:
            if anime.isLiked {
                anime.isLiked = false
            } else {
                anime.isLiked = true
                
                
            }
        }
        
        context.insert(anime)
    }

}
