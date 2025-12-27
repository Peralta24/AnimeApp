//
//  AnimeDetailView-ViewModel.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 26/12/25.
//

import Foundation
import SwiftUI

@Observable
final class AnimeDetailViewModel {
    var showTrailerAlert: Bool = false
    var showTrailerMessage: String?
    
    var anime: AnimeEntry

    init(anime: AnimeEntry) {
        self.anime = anime
    }

    
    var showAddSheet = false
    
    func checkTrailer(open: OpenURLAction) {
        if let url = URL(string: anime.trailer?.youtubeId ?? "") {
            open(url)
        }else {
            showTrailerAlert = true
            showTrailerMessage = "Trailer no disponible"
        }
    }
}
