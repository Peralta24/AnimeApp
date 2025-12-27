//
//  AnimeDetailView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 08/12/25.
//

import SwiftUI
import SwiftData
struct AnimeDetailView: View {
    
    @Environment(\.openURL) var openURL

    @State var vm : AnimeDetailViewModel
    init(anime: AnimeEntry) {
            _vm = State(initialValue: AnimeDetailViewModel(anime: anime))
        }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                AsyncImage(url: URL(string: vm.anime.images.jpg.largeImageUrl ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 250)
                            .clipped()
                    } else if phase.error != nil {
                        ZStack {
                            Color.gray.opacity(0.2)
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)
                        }
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                    } else {
                        ZStack {
                            Color.gray.opacity(0.2)
                            ProgressView()
                        }
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                    }
                }
                
                HStack {
                    AsyncImage(url: URL(string: vm.anime.images.jpg.imageUrl)){phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                            
                            
                            
                        } else if phase.error != nil {
                            ZStack {
                                Color.gray.opacity(0.2)
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundStyle(.gray)
                            }
                        } else {
                            ZStack {
                                Color.gray.opacity(0.2)
                                ProgressView()
                            }
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    VStack (alignment: .leading,spacing: 10){
                        Text(vm.anime.titleEnglish ?? vm.anime.title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.colorTitle)
                        
                        Text("Fecha: \(String(vm.anime.year ?? 0))")
                            .font(.caption)
                            .foregroundStyle(.colorWords)


                        
                        Text(vm.anime.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.colorWords)
                        
                        HStack {
                            HStack {
                                Button {
                                    vm.checkTrailer(open: openURL)
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
                                vm.showAddSheet.toggle()
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
                                Text(String(format:"%.1f",vm.anime.score ?? 5.0))
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
                    AnimeDetailStats(title: "Tipo", value: vm.anime.type ?? "N/A")
                    AnimeDetailStats(title: "Estatus", value: vm.anime.status ?? "N/A")
                    AnimeDetailStats(title: "Episodios", value: String(vm.anime.episodes ?? 0))
                    ForEach(vm.anime.genres ?? [], id: \.self) {genre in
                        AnimeDetailStats(title: "Genero", value: genre.name)
                    }
                    AnimeDetailStats(title: "Ranking Mundial", value: String(vm.anime.popularity ?? 0))
                }
                .padding()
                
            }
            .padding(.top)
            VStack {
                Text("Sinopsis")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.colorTitle)
                Text(vm.anime.synopsis ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.colorWords)
                    .lineSpacing(4)
            }
            .padding()
            
            VStack(alignment:.leading) {
           
            }
        }
        .sheet(isPresented: $vm.showAddSheet, content: {
            AddAnimeView(anime: vm.anime)
        })
        .alert("Aviso", isPresented: $vm.showTrailerAlert) {
            Button("Ok") {
            }
        } message: {
            Text(vm.showTrailerMessage ?? "Trailer no disponible")
        }
        .background(Color.colorBackground)
    }
    
}

#Preview {
    AnimeDetailView(anime: AnimeEntry.example)
}
