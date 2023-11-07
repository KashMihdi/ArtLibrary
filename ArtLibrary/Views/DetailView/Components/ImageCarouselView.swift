//
//  ImageCarouselView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 07.11.2023.
//

import SwiftUI

struct ImageCarouselView: View {
    @Binding var work: Work?
    
    var body: some View {
        if let work {
            VStack {
                Image(systemName: "xmark")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom)
                    .onTapGesture {
                        self.work = nil
                    }
                
                Image(work.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                
                Text(work.info)
                    .font(.subheadline)
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
        }
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        let artist: [Bio] = Bundle.decode(.artists)
        ImageCarouselView(work: .constant(artist[1].works.first!))
    }
}
