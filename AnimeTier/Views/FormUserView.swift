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

    var body: some View {
        NavigationStack {
            Form {
                Section("Datos del usuario") {
                    TextField("Ingresa tu nombre", text: $nombreUsuario)
                    TextField("Ingresa tu apodo", text: $tituloUsuario)
                }
                
                Section("Datos del perfil") {
                    DatePicker(
                        "Fecha de nacimiento",
                        selection: $fechaNacimiento,
                        displayedComponents: .date
                    )

                }
            }
            .navigationTitle("Información")
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
                }
            }
        }
    }
}

