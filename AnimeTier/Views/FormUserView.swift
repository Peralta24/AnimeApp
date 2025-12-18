//
//  FormUserView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 17/12/25.
//

import SwiftUI

struct FormUserView: View {

    @Environment(\.dismiss) private var dismiss
    @Binding var fechaNacimiento: Date
    @Binding var nombreUsuario: String
    @Binding var tituloUsuario: String
    @Binding var generoFavorito: String
    @Binding var descripcion: String

    var body: some View {
        NavigationStack {
            Form {
                
                // MARK: - Usuario
                Section {
                    TextField("Nombre completo", text: $nombreUsuario)
                    TextField("Apodo o nickname", text: $tituloUsuario)
                } header: {
                    Text("Perfil")
                } footer: {
                    Text("Esta información será visible en tu perfil.")
                }

                // MARK: - Preferencias
                Section {
                    DatePicker(
                        "Fecha de nacimiento",
                        selection: $fechaNacimiento,
                        displayedComponents: .date
                    )

                    TextField("Género de anime favorito", text: $generoFavorito)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Descripción")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        ZStack(alignment: .topLeading) {
                            if descripcion.isEmpty {
                                Text("Cuéntanos un poco sobre ti y tus gustos...")
                                    .foregroundStyle(.gray.opacity(0.7))
                                    .padding(.top, 10)
                                    .padding(.leading, 8)
                            }

                            TextEditor(text: $descripcion)
                                .frame(minHeight: 110)
                                .padding(6)
                                .scrollContentBackground(.hidden)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.25))
                        )
                    }
                } header: {
                    Text("Sobre ti")
                }
            }
            .navigationTitle("Información del perfil")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(Color.colorBackground)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar", role: .cancel) {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

