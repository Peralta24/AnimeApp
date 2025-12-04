//
//  ContentView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 02/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var allanimes: [AnimeEntry] = []
    let limiteHorizontal = 6
    var mejoresCalificados: [AnimeEntry] {
        allanimes.filter { ($0.score ?? 0.0) > 8.5 }
    }
    
    var masPopulares: [AnimeEntry] {
        
        let ordenados = allanimes.sorted {
            ($0.popularity ?? 9999) < ($1.popularity ?? 9999)
        }
        return ordenados
    }
    
    var soloRecientes: [AnimeEntry] {
        allanimes
            .filter { ($0.year ?? 0) >= 2020 }
            .sorted { ($0.year ?? 0) > ($1.year ?? 0) }
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.colorBackground
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 30) {
                        
                        VStack(alignment: .leading) {
                            NavigationLink(value:ExploreDestination.explorar){
                                Text("Explorar")
                                    .font(.title2.bold())
                                    .foregroundStyle(.colorTitle)
                                    .padding(.horizontal)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.colorTitle)
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(allanimes.prefix(limiteHorizontal)) { anime in
                                        NavigationLink(value: anime){
                                            AnimeHeroView(anime: anime)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            NavigationLink(value: ExploreDestination.mejoresCalificados){
                                Text("Mejores Calificados")
                                    .font(.title2.bold())
                                    .foregroundStyle(.colorTitle)
                                    .padding(.horizontal)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.colorTitle)
                            }
                            .padding(.horizontal)

                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(mejoresCalificados.prefix(limiteHorizontal)) { anime in
                                        NavigationLink(value: anime) {
                                            AnimeViewCell(anime: anime)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            NavigationLink(value: ExploreDestination.masPopulares){
                                Text("Animes más populares")
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                                    .padding(.horizontal)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.colorTitle)
                            }
                            .padding(.horizontal)

                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(masPopulares.prefix(limiteHorizontal)) { anime in
                                        NavigationLink(value:anime){
                                            AnimeViewCell(anime: anime)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        
                        VStack(alignment: .leading) {
                            NavigationLink(value: ExploreDestination.recientes){
                                Text("Animes más nuevos")
                                    .font(.title2.bold())
                                    .foregroundStyle(.white)
                                    .padding(.horizontal)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.colorTitle)
                            }
                            .padding(.horizontal)

                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(soloRecientes.prefix(limiteHorizontal)) { anime in
                                        NavigationLink(value:anime){
                                            AnimeViewCell(anime: anime)
                                        }
                                        
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .navigationDestination(for: AnimeEntry.self) { anime in
                            Text(anime.titleEnglish ?? "no")
                        }
                        .navigationDestination(for: ExploreDestination.self) { destino in
                            switch destino {
                            case .explorar:
                                AllAnimesGrids(title:"Explorar",animes: allanimes)
                            case .mejoresCalificados:
                                AllAnimesGrids(title:"Mejores Calificados",animes: mejoresCalificados)
                            case .masPopulares:
                                AllAnimesGrids(title:"Mas populares",animes: masPopulares)
                            case .recientes:
                                AllAnimesGrids(title:"Mas recientes",animes: soloRecientes)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .task {
            await fetchAllAnimes()
        }
    }
    
    func fetchAllAnimes() async {
        var loadedAnimes: [AnimeEntry] = []
        var pagina = 1
        let paginasTotales = 4
        while pagina <= paginasTotales {
            guard let url = URL(string: "https://api.jikan.moe/v4/top/anime?page=\(pagina)") else { break }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedData = try JSONDecoder().decode(AnimeResponse.self, from: data)
                
                if decodedData.data.isEmpty { break }
                
                loadedAnimes.append(contentsOf: decodedData.data)
                pagina += 1
            } catch {
                print("Error cargando página \(pagina): \(error)")
                break
            }
        }
                self.allanimes = loadedAnimes
    }}
#Preview {
    ContentView()
}
