//
//  ArtistItem.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

struct ArtistItem: View {
    //@Binding var showDetail: Bool
    let artist: Bio
//    let content: (Bio) -> Content
    
//    init(showDetail: Binding<Bool>, artist: Bio, @ViewBuilder content: @escaping (Bio) -> Content) {
//        self._showDetail = showDetail
//        self.artist = artist
//        self.content = content
//    }
    
    var body: some View {
        HStack(alignment: .center) {
            Image(artist.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80, alignment: .top)
                .clipShape(Circle())
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(separatedBio(text:artist.bio).0)
                    .font(.headline)
                Text(separatedBio(text:artist.bio).1)
                    .font(.subheadline.italic())
            }
            .multilineTextAlignment(.leading)
            .foregroundColor(.black)
        }
//        .onTapGesture {
//            showDetail.toggle()
//        }
//        .navigationDestination(isPresented: $showDetail){
//            content(artist)
//        }
        .padding(.vertical)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
    }
    
    private func separatedBio(text: String) -> (String, String) {
        let text =  artist.bio.components(separatedBy: ")").first!
        let firstBase = text.components(separatedBy: "(")
        return (firstBase[0], firstBase[1])
    }
}

struct ArtistItem_Previews: PreviewProvider {
    static var previews: some View {
        let artist: [Bio] = Bundle.decode(.artists)
        ArtistItem(artist: artist[0])
    }
}
