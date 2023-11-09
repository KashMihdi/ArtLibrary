//
//  ArtGridView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

struct ArtGridView: View {
    let works: [Work]
    let completion: (Work) -> ()
    let gridLayout = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        LazyVGrid(columns: gridLayout, spacing: 20) {
            ForEach(works, id: \.image) { work in
                ZStack {
                    Image(work.image)
                        .resizable()
                        .frame(height: 150)
                        .overlay(
                            Color.black.opacity(0.3)
                        )
                    
                    Text(work.title)
                        .foregroundColor(.white)
                        .font(.title.bold())
                }
                .onTapGesture {
                    completion(work)
                }
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding(.horizontal, 8)
    }
}

struct ArtGridView_Previews: PreviewProvider {
    static var previews: some View {
        let artist: [Bio] = Bundle.decode(.artists)
        ArtGridView(works: artist[0].works) { _ in }
    }
}
