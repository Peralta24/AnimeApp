//
//  ContentView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 02/12/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \AnimeEntry.title)
    private var allanimes: [AnimeEntry]
    
    
    let limiteHorizontal = 6
    
    @Query(filter: #Predicate<AnimeEntry> { $0.score ?? 0.0 > 8.5 },
           sort: \AnimeEntry.score, order: .reverse)
    private var mejoresCalificados: [AnimeEntry]
    
    
    @Query(sort: \AnimeEntry.popularity, order: .forward)
    private var masPopulares: [AnimeEntry]
    
    @Query(filter: #Predicate<AnimeEntry> { $0.year ?? 0 >= 2020 },
           sort: \AnimeEntry.year, order: .reverse)
    private var soloRecientes: [AnimeEntry]
    
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
                                    .foregroundStyle(.colorWords)
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
                                    .foregroundStyle(.colorWords)
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
                                    .foregroundStyle(.colorTitle)
                                    .padding(.horizontal)
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.colorWords)
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
                                    .foregroundStyle(.colorTitle)
                                    .padding(.horizontal)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.colorWords)
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
                                Text("Elementos a mostrar en Grid: \(mejoresCalificados.count)")
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
    
    // MARK: - FUNCIÓN CORREGIDA
    func fetchAllAnimes() async {
        do {
            let count = try modelContext.fetch(FetchDescriptor<AnimeEntry>()).count
            
            if count > 125 {
                print("✅ SwiftData ya contiene \(count) animes. No es necesario recargar.")
                return
            } else {
                if count > 0 {
                    print("⚠️ Datos incompletos (\(count)). Limpiando para recarga completa...")
                    try? modelContext.delete(model: AnimeEntry.self)
                }
            }
        } catch {
            print("Error al verificar SwiftData: \(error)")
        }
        
        var pagina = 1
        let paginasTotales = 5
        
        var allAnimeEntries: [AnimeEntry] = []
        
        print("Iniciando descarga masiva de animes...")
        
        while pagina <= paginasTotales {
            guard let url = URL(string: "https://api.jikan.moe/v4/top/anime?page=\(pagina)") else { break }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(AnimeResponse.self, from: data)
                
                allAnimeEntries.append(contentsOf: decodedResponse.data)
                print("   - Página \(pagina) descargada. Total acumulado: \(allAnimeEntries.count)")
                
                if decodedResponse.data.isEmpty { break }
                
                pagina += 1
                
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                
            } catch {
                print("Error cargando página \(pagina): \(error)")
                break
            }
        }
        
        if !allAnimeEntries.isEmpty {
            print("Guardando \(allAnimeEntries.count) animes en SwiftData...")
            for anime in allAnimeEntries {
                modelContext.insert(anime)
            }
            print("Inserción completa.")
        }
    }
}

#Preview {
    ContentView()
}
