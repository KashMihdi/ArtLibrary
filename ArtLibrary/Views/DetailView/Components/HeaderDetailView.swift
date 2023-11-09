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
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 250)
                .overlay(
                    Text(artist.name)
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                    ,alignment: .bottomLeading
                )
                .overlay(
                    Image(systemName: "info.circle")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.trailing, 30)
                        .padding(.top, 20)
                        .onTapGesture {
                            showDetail.toggle()
                        }
                    , alignment: .topTrailing
                )
                .blur(radius: showDetail ? 8 : 0)
                .shadow(color: .black, radius: 10, x: -5, y: 5)
                //.clipped()
            
            Text(artist.bio)
                .opacity(showDetail ? 1 : 0)
                .padding([.horizontal, .bottom], 40)
                .foregroundColor(.white)
                
        }
        .animation(.linear, value: showDetail)
        .frame(maxWidth: .infinity, maxHeight: 240)
    }
}

struct HeaderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let artist: [Bio] = Bundle.decode(.artists)
        HeaderDetailView(artist: artist[6])
    }
}
