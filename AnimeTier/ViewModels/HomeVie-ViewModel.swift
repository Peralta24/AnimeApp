//
//  HomeVie-ViewModel.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 26/12/25.
//

import Foundation
import LocalAuthentication
import SwiftData
extension HomeView {
    @Observable
    class HomeViewModel {
        private var isUnlocked = false
         var limiteHorizontal = 6

        
        
        func refreshAnimeLogic(using context: ModelContext) async {
            
            do {
                let descriptor = FetchDescriptor<AnimeEntry>()
                let count = try context.fetchCount(descriptor)
                
                if count > 0 {
                    print("Ya existen datos locales. No se descargara de nuevo")
                    return
                }
                
            } catch {
                print("Error verifique la base de datos: \(error.localizedDescription)")
            }
            
            print("Iniciando descarga de la API")
            
            do {
                
                let animesDeLaApi = try await NetworkManager.shared.fetchTopAnimes()
                
                await MainActor.run {
                    for animeNuevo in animesDeLaApi {
                        
                        let idBusqueda  = animeNuevo.id
                        let descriptor = FetchDescriptor<AnimeEntry>(
                            predicate: #Predicate {$0.id == idBusqueda}
                        )
                        
                        do {
                            let resultado = try context.fetch(descriptor)
                            
                            if let animeExistente = resultado.first {
                                
                                animeExistente.score = animeNuevo.score
                                animeExistente.episodes = animeNuevo.episodes
                                animeExistente.popularity = animeNuevo.popularity
                                animeExistente.status = animeNuevo.status
                                animeExistente.images = animeNuevo.images
                                
                                print("Actualizando anime ")
                                
                            } else {
                                context.insert(animeNuevo)
                                print("Insertando un nuevo anime")
                            }
                        } catch {
                            print("Error buscando anime existente: \(error.localizedDescription)")
                        }
                    }
                    
                    try? context.save()
                    print("Sincronizando datos con la base de datos local")
                }
            } catch {
                print("Error critico en la descarga")
            }
        }

        
        
        func authenticate() {
            
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need to unlock your data") {succes, error in
                    if succes{
                        self.isUnlocked = true
                    } else {
                        
                    }
                }
            }
        }
        
    }
}
