//
//  AllAnimesGrids.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 03/12/25.
//

import SwiftUI

struct AllAnimesGrids: View {
    let title: String
    var animes : [AnimeEntry]
    let colums = [
        GridItem(.adaptive(minimum: 100, maximum: 300))
    ]
    var body: some View {
        ZStack {
            Color.colorBackground
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false){                LazyVGrid(columns: colums) {
                    ForEach(animes){anime in
                        AnimeViewCell(anime: anime)
                    }
                }
            }
        }
        .navigationTitle(title)
        .preferredColorScheme(.dark)
    }
    
}

#Preview {
    AllAnimesGrids(title:"aaa",animes: [AnimeEntry.example])
}
