//
//  SubscriptionView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 21/12/25.
//

import SwiftUI

struct SubscriptionView: View {
    var body: some View {
        ZStack {
            Color.colorBackground
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("¿Quieres una experiencia premium?")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.colorTitle)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                    
                    Text("""
                Contamos con diferentes planes de suscripción para que \
                puedas disfrutar de todo lo mejor de la comunidad de fans \
                de anime y manga.
                """)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.colorWords)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal, 32)
                    
                    
                    CardsSubscriptionViews(planSuscripcion: "Normal", precio: 21.90)
                }
                .padding(.top, 16)
            }
        }
        .safeAreaInset(edge: .top) {
            Color.clear.frame(height: 8)
        }
    }
}


#Preview {
    SubscriptionView()
}
