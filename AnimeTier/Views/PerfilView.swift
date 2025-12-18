//
//  PerfilView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 17/12/25.
//
import PhotosUI
import SwiftUI

struct PerfilView: View {

    @State private var imageProfileSelect: PhotosPickerItem?
    @State private var processedImage: Image?

    var body: some View {
        ZStack {
            Color.colorBackground.ignoresSafeArea()

            VStack {
                HStack(alignment: .center, spacing: 16) {

                    ZStack(alignment: .topTrailing) {
                        PhotosPicker(selection: $imageProfileSelect) {
                            if let processedImage = processedImage {
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
                        Text("Mi nombre")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.colorTitle)

                        Text("Título de apodo")
                            .font(.subheadline)
                            .foregroundStyle(.colorWords)
                    }

                    Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.black.opacity(0.25))
                )

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Perfil")
    }

    // MARK: - Imagen
    func loadImage() {
        Task {
            guard let imageData = try await imageProfileSelect?.loadTransferable(type: Data.self),
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
    PerfilView()
}
