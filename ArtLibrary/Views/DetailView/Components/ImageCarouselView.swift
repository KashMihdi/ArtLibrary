//
//  ImageCarouselView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 07.11.2023.
//

import SwiftUI

struct ImageCarouselView: View {
    let work: [Work]
    @State private var dragOffset: CGFloat = 0
    @Binding var step: Arrow
    @Binding var imageIndex: Int?
    
    var body: some View {
        if let imageIndex {
            VStack(spacing: 40) {
                
                ZStack {
                    ForEach(0..<work.count, id: \.self) { index in
                        VStack {
                            Text(work[index].title)
                                .font(.title.bold())
                            
                            Image(work[index].image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                            
                            
                            Text(work[index].info)
                                .font(.subheadline)
                                .padding(.horizontal)
                            
                        }
                        .offset(x: CGFloat(index - imageIndex) * 400 + dragOffset)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 30) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                    .opacity(imageIndex == 0 ? 0 : 1)
                    .onTapGesture {
                        step = .back
                    }
                    Text("\(imageIndex + 1) / \(work.count)")
                    HStack {
                        Text("Next")
                        Image(systemName: "arrow.right")
                    }
                    .opacity(imageIndex == (work.count - 1) ? 0 : 1)
                    .onTapGesture {
                        step = .next
                    }
                }
                .padding()
                .padding(.bottom, 20)
            }
            .safeAreaInset(edge: .top, content: {
                Image(systemName: "xmark")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 30)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        self.imageIndex = nil
                    }
            })
            .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
        }
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        let artist: [Bio] = Bundle.decode(.artists)
        ImageCarouselView(work: artist[0].works, step: .constant(.none), imageIndex: .constant(1))
    }
}

enum Arrow {
    case next, back, none
}
