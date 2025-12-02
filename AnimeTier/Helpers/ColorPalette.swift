//
//  ColorPalette.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 02/12/25.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    
    // 1. FONDO GENERAL (Night Sakura)
    static var colorBackground: Color {
        Color(red: 0.102, green: 0.102, blue: 0.180) // #1A1A2E
    }
    
    // 2. FONDO TARJETAS (Shadow Plum)
    static var colorCardBackground: Color {
        Color(red: 0.227, green: 0.000, blue: 0.639) // #3A0CA3
    }

    // 3. TÍTULOS (Mist White)
    static var colorTitle: Color {
        Color(red: 0.925, green: 0.925, blue: 0.960) // #ECECF5
    }

    // 4. TEXTO PRINCIPAL (Mist Gray)
    static var colorWords: Color {
        Color(red: 0.760, green: 0.760, blue: 0.760) // #C2C2C2
    }
    
    // 5. ACENTO MAGENTA (Neon Magenta)
    static var colorAccentPrimary: Color {
        Color(red: 1.000, green: 0.180, blue: 0.388) // #FF2E63
    }

    // 6. ACENTO AZUL (Spirit Blue)
    static var colorAccentSecondary: Color {
        Color(red: 0.000, green: 0.733, blue: 0.941) // #00BBF0
    }
}
