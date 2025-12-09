//
//  AnimeDetailView.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez on 08/12/25.
//

import SwiftUI

struct AnimeDetailView: View {
    var anime: AnimeEntry
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                AsyncImage(url: URL(string: anime.images.jpg.largeImageUrl ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 250)
                            .clipped()
                    } else if phase.error != nil {
                        ZStack {
                            Color.gray.opacity(0.2)
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)
                        }
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                    } else {
                        ZStack {
                            Color.gray.opacity(0.2)
                            ProgressView()
                        }
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                    }
                }
                
                HStack {
                    AsyncImage(url: URL(string: anime.images.jpg.imageUrl)){phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                            
                            
                        } else if phase.error != nil {
                            ZStack {
                                Color.gray.opacity(0.2)
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundStyle(.gray)
                            }
                        } else {
                            ZStack {
                                Color.gray.opacity(0.2)
                                ProgressView()
                            }
                            .frame(height: 250)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    VStack (alignment: .leading,spacing: 20){
                        Text(anime.titleEnglish ?? anime.title)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.colorTitle)
                        Text(anime.title)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.colorWords)
                        
                        HStack {
                            HStack {
                                Button {
                                    
                                }label : {
                                    Image(systemName: "play")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                        .foregroundStyle(.colorWords)
                                        .fontWeight(.bold)
                                    Text("Trailer")
                                        .foregroundStyle(.colorWords)
                                        .fontWeight(.black)
                                }
                                
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.purple.opacity(0.1))
                            )
                            Button(action: {
                                print("Tapped")
                            }) {
                                Circle()
                                    .fill(.purple.opacity(0.1))
                                    .frame(width: 38, height: 38)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundColor(.white)
                                    )
                                    .shadow(radius: 4)
                            }
                            
                            
                            
                        }
                        
                    }
                }
                .padding(.vertical)
            }
        }
        .background(Color.colorBackground)
    }
}

#Preview {
    AnimeDetailView(anime: AnimeEntry.example)
}
