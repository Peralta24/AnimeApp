//
//  ContentView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 02/12/25.
//

import SwiftUI
import SwiftData

enum RutaPrincipal: Hashable {
    case colecciones
}

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
                        
                        // SECCIÓN EXPLORAR
                        VStack(alignment: .leading) {
                            NavigationLink(value:ExploreDestination.explorar){
                                HeaderView(titulo: "Explorar")
                            }
                            
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
                        
                        // SECCIÓN MEJORES CALIFICADOS
                        VStack(alignment: .leading) {
                            NavigationLink(value: ExploreDestination.mejoresCalificados){
                                HeaderView(titulo: "Mejores Calificados")
                            }
                            
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
                        
                        // SECCIÓN POPULARES
                        VStack(alignment: .leading) {
                            NavigationLink(value: ExploreDestination.masPopulares){
                                HeaderView(titulo: "Animes más populares")
                            }
                            
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
                        
                        // SECCIÓN RECIENTES
                        VStack(alignment: .leading) {
                            NavigationLink(value: ExploreDestination.recientes){
                                HeaderView(titulo: "Animes más nuevos")
                            }
                            
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
                        .preferredColorScheme(.dark)
                    }
                    .padding(.vertical)
                }             }
            .navigationDestination(for: AnimeEntry.self) { anime in
                AnimeDetailView(anime: anime)
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
            .navigationDestination(for: RutaPrincipal.self) { ruta in
                if ruta == .colecciones {
                    ColeccionesView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(value: RutaPrincipal.colecciones) {
                        Text("Ver colecciones")
                    }
                }
            }
        }
        .task {
            await refreshAnimeLogic()
        }
    }
    
    // Helper  de los títulos
    func HeaderView(titulo: String) -> some View {
        HStack {
            Text(titulo)
                .font(.title2.bold())
                .foregroundStyle(.colorTitle)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.colorWords)
        }
        .padding(.horizontal)
    }
    
    func refreshAnimeLogic() async {
        do {
             let count = try modelContext.fetch(FetchDescriptor<AnimeEntry>()).count
             if count > 50 {
                 print("Swift Data ya contiene \(count) animes")
             }else if count > 0 {
                 print("Datos incompletos en Swift Data, se procederá a actualizar los datos")
                 try? modelContext.delete(model: AnimeEntry.self)
             }
         } catch {
             print("Error al verficar la base de datos: \(error)")
         }
         
         do {
             let nuevosAnimes = try await NetworkManager.shared.fetchTopAnimes()
             await MainActor.run {
                 print("Guardando \(nuevosAnimes.count) animes en SwiftData")
                 for anime in nuevosAnimes {
                     modelContext.insert(anime)
                 }
                 try? modelContext.save()
                 print("Insercion exitosa de animes en SwiftData")
             }
         } catch {
             print("Error descargando animes \(error.localizedDescription)")
         }
    }
}

#Preview {
    ContentView()
}
