//
//  HeaderDetailView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

struct HeaderDetailView: View {
    @State private var showDetail = false
    let artist: Bio
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(artist.image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 250)
                .clipped()
                .overlay(
                    Color.black.opacity(showDetail ? 0.3 : 0)
                )
                .blur(radius: showDetail ? 8 : 0)
                .onTapGesture {
                    showDetail.toggle()
                }
                .shadow(color: .black, radius: 10, x: 0, y: 5)
            
            Text(artist.bio)
                .opacity(showDetail ? 1 : 0)
                .padding([.horizontal, .bottom], 40)
                .foregroundColor(.white)
                
        }
        //.clipped()
        .animation(.linear, value: showDetail)
        .frame(maxWidth: .infinity, maxHeight: 250)
    }
}

struct HeaderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let artist: [Bio] = Bundle.decode(.artists)
        HeaderDetailView(artist: artist[6])
    }
}
