//
//  ColeccionesView-ViewModel.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 26/12/25.
//

import Foundation
import SwiftUI

struct ColeccionConfig {
    let titulo: String
    let icon: String
    let color: Color
}
@Observable
final class ColeccionesViewModel {
    
    func estaVacio(favoritos: [AnimeEntry], verMasTarde: [AnimeEntry], meGusta: [AnimeEntry]) -> Bool {
        favoritos.isEmpty && verMasTarde.isEmpty && meGusta.isEmpty
    }
    
    let verMasTarde = ColeccionConfig(titulo: "Ver mas tarde", icon: "clock.fill", color: .blue)
    
    let meGusta = ColeccionConfig(titulo: "Me gusta", icon: "heart.fill", color: .red)
    
    let favoritos = ColeccionConfig(titulo: "Favoritos", icon: "start.fill", color: .yellow)
}
