//
//  ColeccionesView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 13/12/25.
//

import SwiftUI
import SwiftData

struct RutaColeccion: Hashable {
    let titulo: String
    let animes: [AnimeEntry]
}

struct ColeccionesView: View {
    
    @Query(filter: #Predicate<AnimeEntry>{$0.isFavorite})
    var animeFavoritos: [AnimeEntry]
    
    @Query(filter: #Predicate<AnimeEntry>{$0.isWatchLater})
    var animesMasTarder: [AnimeEntry]
    
    @Query(filter: #Predicate<AnimeEntry>{$0.isLiked})
    var animesMeGusta: [AnimeEntry]
        
    @State private var vm = ColeccionesViewModel()
    var body: some View {
        ZStack {
            Color.colorBackground.ignoresSafeArea()
            
            if vm.estaVacio(favoritos: animeFavoritos, verMasTarde: animesMasTarder, meGusta: animesMeGusta) {
                ContentUnavailableView(
                    "No hay colecciones",
                    systemImage: "square.stack.3d.up.slash",
                    description: Text("Empieza a agregar animes para ver aquí tus colecciones.")
                )
            } else {
                ScrollView {
                    VStack(spacing:30) {
                        
                        if !animeFavoritos.isEmpty {
                            AnimeShelfView(titulo: vm.favoritos.titulo, animes: animeFavoritos, icon: vm.favoritos.icon, color: vm.favoritos.color)
                        }
                        
                        if !animesMasTarder.isEmpty {
                            AnimeShelfView(titulo: vm.verMasTarde.titulo, animes: animesMasTarder, icon: vm.verMasTarde.icon, color: vm.verMasTarde.color)
                        }
                        
                        if !animesMeGusta.isEmpty {
                            AnimeShelfView(titulo: vm.meGusta.titulo, animes: animesMeGusta, icon: vm.meGusta.icon, color: vm.meGusta.color)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationTitle("Colecciones")
        .navigationDestination(for: AnimeEntry.self, destination: { anime in
            AnimeDetailView(anime: anime)
        })
        .navigationDestination(for: RutaColeccion.self) { ruta in
            AllAnimesGrids(title: ruta.titulo, animes: ruta.animes)
        }
    }
}


struct AnimeShelfView: View {
    let titulo: String
    let animes: [AnimeEntry]
    let icon: String
    let color: Color
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            NavigationLink(value: RutaColeccion(titulo: titulo, animes: animes)) {
                HStack {
                    Label(titulo, systemImage: icon)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(color)
                    Spacer()
                    
                    Text("Ver todo")
                        .font(.caption)
                        .foregroundStyle(.colorWords)
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.colorWords)
                }
                .padding(.horizontal)
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing:15){
                    ForEach(animes) {anime in
                        NavigationLink(value:anime) {
                            AnimeViewCell(anime: anime)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }


        }
        
    }
    
}
