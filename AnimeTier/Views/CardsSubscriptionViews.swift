//
//  CardsSubscriptionViews.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 21/12/25.
//

import SwiftUI

struct CardsSubscriptionViews: View {
    var planSuscripcion: String
    var precio: Double

    let beneficions = [
        "Servicio",
        "Ventajas",
        "Sin anuncios",
        "Bonificaciones"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 16) {

            Image(systemName: "crown.fill")
                .font(.system(size: 28))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.yellow.opacity(0.9),
                            Color.orange.opacity(0.8)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .padding(.top, 20)

            Text(planSuscripcion)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.colorTitle)

            Text("$\(precio, specifier: "%.2f") / mes")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.white)
            
            LazyHGrid(rows: columns, spacing: 12) {
                ForEach(beneficions, id: \.self) { beneficio in
                    HStack(spacing: 6) {

                        Text("+")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.colorAccentPrimary.opacity(0.8))

                        Text(beneficio)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.colorWords.opacity(0.85))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(height: 80)
            .padding(.horizontal, 12)

            
            Text("Suscribirse")
                .padding(10)
                .background(.purple)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.colorTitle)
                .clipShape(.capsule)

            Spacer()
        }
        .frame(width: 300, height: 320)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.colorCardBackground.opacity(0.9))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.25), radius: 12, y: 6)
    }
}


#Preview {
    CardsSubscriptionViews(planSuscripcion: "Premium", precio: 29.99)
}
