//
//  ContentView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 02/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var allanimes: [AnimeEntry] = []
    
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
                                    ForEach(allanimes) { anime in
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
                                    ForEach(mejoresCalificados) { anime in
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
                                    ForEach(masPopulares) { anime in
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
                                    ForEach(soloRecientes) { anime in
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
                                Text("Explorar")
                            case .mejoresCalificados:
                                Text("Mejores calificados")
                            case .masPopulares:
                                Text("Mas populares")
                            case .recientes:
                                Text("recientes")
                            default:
                                Text("No se encontro")
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .task {
            await fetchAnimes()
        }
    }
    
    func fetchAnimes() async {
        guard let url = URL(string: "https://api.jikan.moe/v4/top/anime")else {
            return
        }
        
        do {
            let(data,_) = try await URLSession.shared.data(from: url)
            
            let decodedData = try JSONDecoder().decode(AnimeResponse.self, from: data)
            
            self.allanimes = decodedData.data
        }catch {
            print("Error cargando API anime")
        }
    }
}
#Preview {
    ContentView()
}
