//
//  CarouselItem.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 11.11.2023.
//

import SwiftUI

struct CarouselItem: View {
    let work: [Work]
    let imageIndex: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<work.count, id: \.self) { index in
                    VStack {
                        Text(work[index].title)
                            .font(.title.bold())
                        
                        Image(work[index].image)
                            .resizable()
                            .scaledToFit()
                        
                        Text(work[index].info)
                            .font(.subheadline)
                            .padding(.horizontal)
                    }
                    .offset(x: CGFloat(index - imageIndex) * geo.size.width)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
    }
}

struct CarouselItem_Previews: PreviewProvider {
    static var previews: some View {
        CarouselItem(work: dev.works, imageIndex: 1)
    }
}
