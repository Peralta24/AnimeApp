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
                            Text("Mejores Calificados")
                                .font(.title2.bold())
                                .foregroundStyle(.colorTitle)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(mejoresCalificados) { anime in
                                        AnimeViewCell(anime: anime)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Animes más populares")
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(masPopulares) { anime in
                                        AnimeViewCell(anime: anime)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Animes más nuevos")
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(soloRecientes) { anime in
                                        AnimeViewCell(anime: anime)
                                    }
                                }
                                .padding(.horizontal)
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
