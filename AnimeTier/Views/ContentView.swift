//
//  ContentView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 02/12/25.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {

            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Inicio", systemImage: "house.fill")
            }

            NavigationStack {
                ColeccionesView()
            }
            .tabItem {
                Label("Colecciones", systemImage: "square.stack.fill")
            }
            NavigationStack {
                PerfilView()
            }
            .tabItem{
                Label("Perfil", systemImage: "person.circle")
            }
        }
    }
}

#Preview {
    ContentView()
}
