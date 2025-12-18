//
//  PerfilView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 17/12/25.
//

import PhotosUI
import SwiftUI

struct PerfilView: View {

    @State private var imageProfileSelect: PhotosPickerItem?
    @State private var processedImage: Image?

    @State private var showFormInfo = false
    @State private var nombreUsuario: String = ""
    @State private var tituloUsuario: String = ""
    @State private var fechaNacimiento: Date = .now

    var body: some View {
        ZStack {
            Color.colorBackground
                .ignoresSafeArea()

            VStack {
                HStack(alignment: .center, spacing: 40) {

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
                                    .foregroundStyle(.colorWords)
                                    .padding(20)
                            }
                        }
                        .frame(width: 100, height: 100)
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
                        Text(nombreUsuario.isEmpty ? "Nombre" : nombreUsuario)
                            .font(.title2.bold())
                            .foregroundStyle(
                                nombreUsuario.isEmpty ? .gray.opacity(0.6) : .colorTitle
                            )

                        Text(tituloUsuario.isEmpty ? "Titulo no establecido" : tituloUsuario)
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
                            .padding(.bottom,80)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.black.opacity(0.25))
                )

                Spacer()
            }
            .padding()
            
            
            VStack(alignment: .leading, spacing: 12) {

                Label {
                    Text("Fecha de nacimiento")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } icon: {
                    Image(systemName: "calendar")
                }

                Text(fechaNacimiento.formatted(date: .long, time: .omitted))
                    .font(.headline)
                    .foregroundStyle(.colorTitle)

            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.black.opacity(0.25))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.05))
            )
            .padding(.horizontal)

            
            Spacer()

        }
        .navigationTitle("Perfil")
        .sheet(isPresented: $showFormInfo) {
            FormUserView(
                fechaNacimiento: $fechaNacimiento,
                nombreUsuario: $nombreUsuario,
                tituloUsuario: $tituloUsuario
            )
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
