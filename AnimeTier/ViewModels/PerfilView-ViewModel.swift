//
//  PerfilView-ViewModel.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 26/12/25.
//

import Foundation
import PhotosUI
import SwiftData
import _PhotosUI_SwiftUI
import SwiftUI

@Observable
final class PerfilViewModel {
    // MARK: Variables de estado de Perfil
     var imageProfileSelect: PhotosPickerItem?
     var processedImage: Image?
    
     var showFormInfo = false
     var nombreUsuario: String = ""
     var tituloUsuario: String = ""
     var fechaNacimiento: Date = .now
     var generoFavoritos: String = ""
     var descripcionUsuario: String = ""
    
    
    // MARK: Funcion para cargar e eliminar las imagenes
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
