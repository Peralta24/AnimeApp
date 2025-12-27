//
//  AnimeImageView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 26/12/25.
//

import SwiftUI

struct AnimeImageView: View {
    let urlString: String?
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    var contentMode : ContentMode = .fill
    var body: some View {
        AsyncImage(url: URL(string: urlString ?? "")) {phase in
            switch phase {
            case .empty:
                ZStack{
                    Color.gray.opacity(0.2)
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            case .failure(let error):
                ZStack {
                    Color.gray.opacity(0.2)
                    Image(systemName: "photo")
                        .font(.title2)
                        .foregroundStyle(.gray)
                }
                 default:
                EmptyView()
            }
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    AnimeImageView(urlString: "")
}
