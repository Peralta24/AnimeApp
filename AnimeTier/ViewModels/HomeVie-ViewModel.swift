//
//  HomeViewModel.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 26/12/25.
//

import Foundation
import LocalAuthentication
import SwiftData

@Observable
final class HomeViewModel {

    // MARK: - UI Configuration
    
    /// Número máximo de animes a mostrar en los carruseles horizontales
    var limiteHorizontal: Int = 6

    // MARK: - State
    
    /// Indica si el usuario ha sido autenticado con biometría
    private(set) var isUnlocked: Bool = false

    // MARK: - Public Methods
    
    /// Sincroniza los animes desde la API hacia SwiftData
    /// - Parameter context: ModelContext proporcionado por la View
    @MainActor
    func refreshAnimeLogic(using context: ModelContext) async {

        // Verificar si ya existen datos locales
        do {
            let descriptor = FetchDescriptor<AnimeEntry>()
            let count = try context.fetchCount(descriptor)

            if count > 0 {
                print("Ya existen datos locales. No se descargará de nuevo.")
                return
            }
        } catch {
            print("Error verificando la base de datos: \(error.localizedDescription)")
        }

        print("Iniciando descarga de la API")

        do {
            let animesDeLaApi = try await NetworkManager.shared.fetchTopAnimes()

            for animeNuevo in animesDeLaApi {

                let descriptor = FetchDescriptor<AnimeEntry>(
                    predicate: #Predicate { $0.id == animeNuevo.id }
                )

                do {
                    let resultado = try context.fetch(descriptor)

                    if let animeExistente = resultado.first {
                        // Actualizar anime existente
                        animeExistente.score = animeNuevo.score
                        animeExistente.episodes = animeNuevo.episodes
                        animeExistente.popularity = animeNuevo.popularity
                        animeExistente.status = animeNuevo.status
                        animeExistente.images = animeNuevo.images
                    } else {
                        // Insertar nuevo anime
                        context.insert(animeNuevo)
                    }
                } catch {
                    print("Error buscando anime existente: \(error.localizedDescription)")
                }
            }

            try? context.save()
            print("Sincronización completada")
        } catch {
            print("Error crítico al descargar los animes")
        }
    }

    // MARK: - Biometric Authentication
    
    /// Autentica al usuario usando Face ID / Touch ID
    func authenticate() {

        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                       error: &error) else {
            return
        }

        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Necesitamos autenticarte para continuar"
        ) { success, _ in
            if success {
                DispatchQueue.main.async {
                    self.isUnlocked = true
                }
            }
        }
    }
}
