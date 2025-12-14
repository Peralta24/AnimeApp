//
//  AnimeDetailStats.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 14/12/25.
//

import SwiftUI

struct AnimeDetailStats: View {
    let title : String
    let value: String
    let color: Color =  .colorCardBackground
    var body: some View {
        VStack(spacing:4){
            Text(title)
                .font(.caption2)
                .foregroundStyle(.colorTitle.opacity(0.7))
                
                Text(value)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.colorTitle)
            
        }
        .padding(.horizontal,10)
        .padding(.vertical,6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(color.opacity(0.75))
        )
    }
}
