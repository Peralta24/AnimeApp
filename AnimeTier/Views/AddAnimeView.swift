//
//  AddAnimeView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 10/12/25.
//

import SwiftUI
struct CircleOption: ViewModifier {
    var size: CGFloat = 90
    var background: Color = .colorCardBackground
    
    func body(content: Content) -> some View {
        ZStack {
            Circle()
                .fill(background)
                .frame(width: size, height: size)
            content
        }
    }
}

extension View {
    func circleIcon(size: CGFloat = 90,
                    background:Color = .colorCardBackground) -> some View {
        self.modifier(CircleOption(size: size, background: background))
    }
}

struct AddAnimeView: View {
    @State var animesFavoritos: [AnimeEntry] = []
    @State var animesVerMasTarde: [AnimeEntry] = []
    @State var animesMeGusta: [AnimeEntry] = []
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    @State private var messageAlert = ""
    
    var anime: AnimeEntry
    var body: some View {
        NavigationStack{
            ZStack {
                Color.colorBackground
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack(spacing:15) {
                        AsyncImage(url: URL(string: anime.images.jpg.largeImageUrl ?? "")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(width: 160, height:200 )
                                    .clipped()
                            } else if phase.error != nil {
                                ZStack {
                                    Color.gray.opacity(0.2)
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                        .foregroundStyle(.gray)
                                }
                                .frame(width: 60, height: 90)
                                .frame(maxWidth: .infinity)
                            } else {
                                ZStack {
                                    Color.gray.opacity(0.2)
                                    ProgressView()
                                }
                                .frame(width: 60, height: 90)
                                .frame(maxWidth: .infinity)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(anime.title)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Añadir a tu colección")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    Spacer()
                    
                    HStack(spacing:30) {
                        Button {
                            agregarAnime(.favorito)
                        }label: {
                            VStack (spacing: 5){
                                
                                Image(systemName: "plus")
                                    .font(.system(size: 20,weight: .bold))
                                    .foregroundStyle(.colorWords)
                                    .circleIcon()
                                Text("Favoritos")
                                    .font(.caption)
                                    .foregroundStyle(.colorWords)
                            }
                        }
                        Button {
                            agregarAnime(.verMasTarde)
                        }label: {
                            
                            VStack(spacing:5) {
                                Image(systemName: "clock")
                                    .font(.system(size: 20,weight: .bold))
                                    .foregroundStyle(.colorWords)
                                    .circleIcon()
                                Text("Ver mas tarde")
                                    .font(.caption)
                                    .foregroundStyle(.colorWords)
                            }
                        }
                        Button {
                            agregarAnime(.meGusta)
                        }label: {
                            
                            
                            VStack(spacing:5) {
                                Image(systemName: "heart")
                                    .font(.system(size: 20,weight: .bold))
                                    .foregroundStyle(.colorWords)
                                    .circleIcon()
                                Text("Me gusta")
                                    .font(.caption)
                                    .foregroundStyle(.colorWords)
                            }
                        }
                    }
                    .padding()
                    
                    
                    Spacer()
                        .alert("Anime agregado!",isPresented: $showAlert) {
                            Button("Ok") {
                                
                            }
                            NavigationLink("Coleccion") {
                                ColeccionesView()
                            }
                            
                        }message: {
                            Text(messageAlert)
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading){
                                Button("Cancelar") {
                                    dismiss()
                                }
                            }
                        }
                }
                .padding()
            }
        }
    }
    enum TipoColeccion {
        case favorito
        case verMasTarde
        case meGusta
    }
    func agregarAnime(_ tipo: TipoColeccion) {
        
        switch tipo {
        case .favorito:
            if anime.isFavorite {
                messageAlert = "Ya esta en favoritos"
            } else {
                messageAlert = "Agregado a favoritos"
                anime.isFavorite = true
                
                
            }
        case .verMasTarde:
            if anime.isWatchLater {
                messageAlert = "Ya esta en ver mas tarde"
            } else {
                messageAlert = "Agregado a ver mas tarde"
                anime.isWatchLater = true
                
                
            }
        case .meGusta:
            if anime.isLiked {
                messageAlert = "Ya esta en me gusta"
            } else {
                messageAlert = "Agregado a me gusta"
                anime.isLiked = true
                
                
            }
        }
        
        showAlert = true
        modelContext.insert(anime)
    }
}

#Preview {
    AddAnimeView(anime: AnimeEntry.example)
}
