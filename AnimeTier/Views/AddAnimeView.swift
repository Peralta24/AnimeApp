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
    
    @State  var vm : AddAnimeViewModel
    init(anime: AnimeEntry) {
            _vm = State(initialValue: AddAnimeViewModel(anime: anime))
        }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.colorBackground
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack(spacing:15) {
                        AsyncImage(url: URL(string: vm.anime.images.jpg.largeImageUrl ?? "")) { phase in
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
                            Text(vm.anime.title)
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
                            vm.toogle(.favorito, using: modelContext)
                        }label: {
                            VStack (spacing: 5){
                                
                                Image(systemName: vm.anime.isFavorite ? "bookmark.fill" :"bookmark")
                                    .font(.system(size: 20,weight: .bold))
                                    .foregroundStyle(vm.anime.isFavorite ? .yellow :.colorWords)
                                    .circleIcon()
                                Text("Favoritos")
                                    .font(.caption)
                                    .foregroundStyle(.colorWords)
                            }
                        }
                        Button {
                            vm.toogle(.verMasTarde, using: modelContext)
                        }label: {
                            
                            VStack(spacing:5) {
                                Image(systemName: vm.anime.isWatchLater ? "clock.fill" :"clock")
                                    .font(.system(size: 20,weight: .bold))
                                    .foregroundStyle(vm.anime.isWatchLater ? .blue : .colorWords)
                                    .circleIcon()
                                Text("Ver mas tarde")
                                    .font(.caption)
                                    .foregroundStyle(.colorWords)
                            }
                        }
                        Button {
                            vm.toogle(.meGusta, using: modelContext)
                        }label: {
                            
                            
                            VStack(spacing:5) {
                                Image(systemName: vm.anime.isLiked ? "heart.fill" :"heart")
                                    .font(.system(size: 20,weight: .bold))
                                    .foregroundStyle(vm.anime.isLiked ? .red : .colorWords)
                                    .circleIcon()
                                Text("Me gusta")
                                    .font(.caption)
                                    .foregroundStyle(.colorWords)
                            }
                        }
                    }
                    .padding()
                    
                    
                    Spacer()
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
}

#Preview {
    AddAnimeView(anime: AnimeEntry.example)
}
