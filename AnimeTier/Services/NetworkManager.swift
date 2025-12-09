//
//  NetworkManager.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 09/12/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    //La funcion devuelve un array de AnimeEntry
    func fetchTopAnimes(totalPaginas: Int = 2) async throws -> [AnimeEntry] {
        var allAnimesEntries: [AnimeEntry] = []
        var pagina = 1
        
        print("NetworkManager: Iniciando descar de \(pagina) paginas")
        
        while pagina <= totalPaginas {
            guard let url = URL(string: "https://api.jikan.moe/v4/top/anime?page=\(pagina)") else {
                break
            }
            
            let(data,_) = try await URLSession.shared.data(from: url)
            let decodesResponse = try JSONDecoder().decode(AnimeResponse.self, from: data)
            
            allAnimesEntries.append(contentsOf: decodesResponse.data)
            
            if decodesResponse.data.isEmpty { break }
            
            pagina += 1
            
            try? await Task.sleep(nanoseconds: 1_000_000_000)
        }
        print("Network: Descarga finalizada. Total recuperado: \(allAnimesEntries.count)")
        return allAnimesEntries
    }
}
