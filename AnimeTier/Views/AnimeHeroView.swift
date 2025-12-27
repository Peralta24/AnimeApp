//
//  AnimeHeroView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 03/12/25.
//

import SwiftUI

struct AnimeHeroView: View {
    var anime : AnimeEntry
    var body: some View {
        
        VStack {
            AnimeImageView(urlString: anime.images.jpg.imageUrl,width: 350, height: 250)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.colorCardBackground, lineWidth: 1)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            
            Text(anime.title)
                .font(.caption)
                .bold()
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 120)
                .foregroundStyle(.colorWords)
        }
    }
}

#Preview {
    AnimeHeroView(anime: AnimeEntry.example)
}
