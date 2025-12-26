//
//  PerfilView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 17/12/25.
//

import PhotosUI
import SwiftUI
import SwiftData

struct PerfilView: View {

    @State private var vm = PerfilViewModel()
    
    @Query(filter: #Predicate<AnimeEntry> { $0.isFavorite })
    var animeFavoritos: [AnimeEntry]

    var body: some View {
        ZStack {
            Color.colorBackground
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    
                    HStack(spacing: 24) {
                        
                        ZStack(alignment: .topTrailing) {
                            PhotosPicker(selection: $vm.imageProfileSelect) {
                                if let image = vm.processedImage {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } else {
                                    Image(systemName: "person.crop.circle.badge.plus")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.colorWords.opacity(0.7))
                                        .padding(22)
                                }
                            }
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .buttonStyle(.plain)
                            .onChange(of: vm.imageProfileSelect, vm.loadImage)
                            
                            if vm.processedImage != nil {
                                Button(action: vm.removeImage) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title3)
                                        .foregroundStyle(.red)
                                        .background(.ultraThinMaterial)
                                        .clipShape(Circle())
                                }
                                .offset(x: 6, y: -6)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(vm.nombreUsuario.isEmpty ? "Tu nombre" : vm.nombreUsuario)
                                .font(.title2.bold())
                                .foregroundStyle(
                                    vm.nombreUsuario.isEmpty ? .gray.opacity(0.6) : .colorTitle
                                )
                            
                            Text(vm.tituloUsuario.isEmpty ? "Sin título personalizado" : vm.tituloUsuario)
                                .font(.subheadline)
                                .foregroundStyle(
                                    vm.tituloUsuario.isEmpty ? .gray.opacity(0.6) : .colorWords
                                )
                        }
                        
                        Spacer()
                        
                        Button {
                            vm.showFormInfo = true
                        } label: {
                            Image(systemName: "pencil.circle")
                                .font(.title2)
                                .foregroundStyle(.colorTitle)
                                .padding(.bottom,80)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.black.opacity(0.25))
                    )
                    
                    VStack(alignment: .leading, spacing: 14) {
                        
                        infoLabel("Fecha de nacimiento", icon: "calendar")
                        Text(vm.fechaNacimiento.formatted(date: .long, time: .omitted))
                            .font(.headline)
                            .foregroundStyle(.colorTitle)
                        
                        Divider().opacity(0.3)
                        
                        infoLabel("Animes favoritos", icon: "bookmark.fill")
                        if animeFavoritos.isEmpty {
                            Text("Aún no has marcado animes como favoritos")
                                .font(.subheadline)
                                .foregroundStyle(.gray.opacity(0.6))
                        } else {
                            HStack {
                                ForEach(animeFavoritos) { anime in
                                    AnimeViewCell(anime: anime)
                                }
                            }
                        }
                        
                        Divider().opacity(0.3)
                        
                        infoLabel("Género favorito", icon: "sparkles")
                        Text(vm.generoFavoritos.isEmpty ? "No especificado" : vm.generoFavoritos)
                            .font(.headline)
                            .foregroundStyle(
                                vm.generoFavoritos.isEmpty ? .gray.opacity(0.6) : .colorTitle
                            )
                        
                        Divider().opacity(0.3)
                        
                        infoLabel("Descripción", icon: "text.alignleft")
                        Text(vm.descripcionUsuario.isEmpty
                             ? "Aún no has agregado una descripción"
                             : vm.descripcionUsuario
                        )
                        .font(.body)
                        .foregroundStyle(
                            vm.descripcionUsuario.isEmpty ? .gray.opacity(0.6) : .colorTitle
                        )
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.black.opacity(0.25))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.white.opacity(0.05))
                    )
                    
                    Spacer()
                }
                .padding()

            }
            .scrollBounceBehavior(.basedOnSize)

            .navigationTitle("Perfil")
            .sheet(isPresented: $vm.showFormInfo) {
                FormUserView(
                    fechaNacimiento: $vm.fechaNacimiento,
                    nombreUsuario: $vm.nombreUsuario,
                    tituloUsuario: $vm.tituloUsuario,
                    generoFavorito: $vm.generoFavoritos,
                    descripcion: $vm.descripcionUsuario
                )
            }
        }
    }

    // MARK: - Helpers visuales
    @ViewBuilder
    func infoLabel(_ text: String, icon: String) -> some View {
        Label {
            Text(text)
                .font(.caption)
                .foregroundStyle(.secondary)
        } icon: {
            Image(systemName: icon)
        }
    }

}

#Preview {
    NavigationStack {
        PerfilView()
    }
}
