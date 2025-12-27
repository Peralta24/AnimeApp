//
//  AnimeDetailView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 08/12/25.
//

import SwiftUI
import SwiftData
struct AnimeDetailView: View {
    var anime: AnimeEntry
    @Environment(\.openURL) var openURL
    @State private var showTrailerAlert: Bool = false
    @State private var showTrailerMessage: String?
    
    @State private var showAddSheet = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                AnimeImageView(urlString: anime.images.jpg.largeImageUrl,
                               width: .infinity,
                               height: 250
                               
                )
                .clipped()
                HStack {
                    AnimeImageView(urlString: anime.images.jpg.imageUrl, width: 150, height: 150)
                    VStack (alignment: .leading,spacing: 10){
                        Text(anime.titleEnglish ?? anime.title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.colorTitle)
                        
                        Text("Fecha: \(String(anime.year ?? 0))")
                            .font(.caption)
                            .foregroundStyle(.colorWords)
                        
                        
                        
                        Text(anime.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.colorWords)
                        
                        HStack {
                            HStack {
                                Button {
                                    checkTrailer()
                                }label : {
                                    Image(systemName: "play")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                        .foregroundStyle(.colorWords)
                                        .fontWeight(.bold)
                                    Text("Trailer")
                                        .font(.caption)
                                        .foregroundStyle(.colorWords)
                                        .fontWeight(.black)
                                }
                                
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.purple.opacity(0.1))
                            )
                            Button(action: {
                                showAddSheet.toggle()
                            }) {
                                Circle()
                                    .fill(.purple.opacity(0.1))
                                    .frame(width: 38, height: 38)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundColor(.colorWords)
                                    )
                                    .shadow(radius: 4)
                            }
                            VStack {
                                Text(String(format:"%.1f",anime.score ?? 5.0))
                                    .font(.title)
                                    .fontWeight(.black)
                                    .foregroundStyle(.colorTitle)
                                Text("SCORE")
                                    .font(.headline)
                                    .foregroundStyle(.colorWords)
                                
                            }
                        }
                    }
                }
                .padding(.vertical)
                
            }
            ScrollView(.horizontal,showsIndicators: false){
                HStack {
                    AnimeDetailStats(title: "Tipo", value: anime.type ?? "N/A")
                    AnimeDetailStats(title: "Estatus", value: anime.status ?? "N/A")
                    AnimeDetailStats(title: "Episodios", value: String(anime.episodes ?? 0))
                    ForEach(anime.genres ?? [], id: \.self) {genre in
                        AnimeDetailStats(title: "Genero", value: genre.name)
                    }
                    AnimeDetailStats(title: "Ranking Mundial", value: String(anime.popularity ?? 0))
                }
                .padding()
                
            }
            .padding(.top)
            VStack {
                Text("Sinopsis")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.colorTitle)
                Text(anime.synopsis ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.colorWords)
                    .lineSpacing(4)
            }
            .padding()
            
            VStack(alignment:.leading) {
                
            }
        }
        .sheet(isPresented: $showAddSheet, content: {
            AddAnimeView(anime: anime)
        })
        .alert("Aviso", isPresented: $showTrailerAlert) {
            Button("Ok") {
            }
        } message: {
            Text(showTrailerMessage ?? "Trailer no disponible")
        }
        .background(Color.colorBackground)
    }
    func checkTrailer() {
        if let url = URL(string: anime.trailer?.youtubeId ?? "") {
            openURL(url)
        }else {
            showTrailerAlert = true
            showTrailerMessage = "Trailer no disponible"
        }
    }
}

#Preview {
    AnimeDetailView(anime: AnimeEntry.example)
}
