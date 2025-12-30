//
//  ColeccionesView-ViewModel.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 26/12/25.
//

import Foundation
import SwiftUI
// MARK: Configuracion de colecciones

/// Atributos actuales de cada coleccion
struct ColeccionConfig {
    let titulo: String
    let icon: String
    let color: Color
}
@Observable
final class ColeccionesViewModel {
    
    // MARK: Funcion que recibe los animes y retorna T o F para cambiar la vista
    func estaVacio(favoritos: [AnimeEntry], verMasTarde: [AnimeEntry], meGusta: [AnimeEntry]) -> Bool {
        favoritos.isEmpty && verMasTarde.isEmpty && meGusta.isEmpty
    }
    
    // MARK: Colecciones actuales
    /// Podemos agregar mas colecciones si deseamos 
    let verMasTarde = ColeccionConfig(titulo: "Ver mas tarde", icon: "clock.fill", color: .blue)
    
    let meGusta = ColeccionConfig(titulo: "Me gusta", icon: "heart.fill", color: .red)
    
    let favoritos = ColeccionConfig(titulo: "Favoritos", icon: "star.fill", color: .yellow)
}
