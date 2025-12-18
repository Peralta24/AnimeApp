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

    @State private var imageProfileSelect: PhotosPickerItem?
    @State private var processedImage: Image?

    @State private var showFormInfo = false
    @State private var nombreUsuario: String = ""
    @State private var tituloUsuario: String = ""
    @State private var fechaNacimiento: Date = .now
    @State private var generoFavoritos: String = ""
    @State private var descripcionUsuario: String = ""
    
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
                            PhotosPicker(selection: $imageProfileSelect) {
                                if let processedImage {
                                    processedImage
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
                            .onChange(of: imageProfileSelect, loadImage)
                            
                            if processedImage != nil {
                                Button(action: removeImage) {
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
                            Text(nombreUsuario.isEmpty ? "Tu nombre" : nombreUsuario)
                                .font(.title2.bold())
                                .foregroundStyle(
                                    nombreUsuario.isEmpty ? .gray.opacity(0.6) : .colorTitle
                                )
                            
                            Text(tituloUsuario.isEmpty ? "Sin título personalizado" : tituloUsuario)
                                .font(.subheadline)
                                .foregroundStyle(
                                    tituloUsuario.isEmpty ? .gray.opacity(0.6) : .colorWords
                                )
                        }
                        
                        Spacer()
                        
                        Button {
                            showFormInfo = true
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.colorTitle)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.black.opacity(0.25))
                    )
                    
                    // MARK: - Información
                    VStack(alignment: .leading, spacing: 14) {
                        
                        infoLabel("Fecha de nacimiento", icon: "calendar")
                        Text(fechaNacimiento.formatted(date: .long, time: .omitted))
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
                        Text(generoFavoritos.isEmpty ? "No especificado" : generoFavoritos)
                            .font(.headline)
                            .foregroundStyle(
                                generoFavoritos.isEmpty ? .gray.opacity(0.6) : .colorTitle
                            )
                        
                        Divider().opacity(0.3)
                        
                        infoLabel("Descripción", icon: "text.alignleft")
                        Text(descripcionUsuario.isEmpty
                             ? "Aún no has agregado una descripción"
                             : descripcionUsuario
                        )
                        .font(.body)
                        .foregroundStyle(
                            descripcionUsuario.isEmpty ? .gray.opacity(0.6) : .colorTitle
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
            .sheet(isPresented: $showFormInfo) {
                FormUserView(
                    fechaNacimiento: $fechaNacimiento,
                    nombreUsuario: $nombreUsuario,
                    tituloUsuario: $tituloUsuario,
                    generoFavorito: $generoFavoritos,
                    descripcion: $descripcionUsuario
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

    func loadImage() {
        Task {
            guard
                let imageData = try await imageProfileSelect?.loadTransferable(type: Data.self),
                let uiImage = UIImage(data: imageData)
            else { return }

            await MainActor.run {
                processedImage = Image(uiImage: uiImage)
            }
        }
    }

    func removeImage() {
        processedImage = nil
        imageProfileSelect = nil
    }
}

#Preview {
    NavigationStack {
        PerfilView()
    }
}
