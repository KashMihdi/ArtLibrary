//
//  ImageCarouselView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 07.11.2023.
//

import SwiftUI

struct ImageCarouselView: View {
    @State private var step: Arrow = .none
    let work: [Work]
    var imageIndex: Int?
    let completion: (Arrow) -> ()
    
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
                        .offset(x: CGFloat(index - imageIndex) * 400)
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
                        completion(step)
                        
                    }
                    Text("\(imageIndex + 1) / \(work.count)")
                    HStack {
                        Text("Next")
                        Image(systemName: "arrow.right")
                    }
                    .opacity(imageIndex == (work.count - 1) ? 0 : 1)
                    .onTapGesture {
                        step = .next
                        completion(step)
                    }
                }
                .animation(nil, value: imageIndex)
                .padding()
                .padding(.bottom, 20)
            }
            .safeAreaInset(edge: .top) {
                Image(systemName: "xmark")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 30)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        step = .none
                        completion(step)
                    }
            }
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
        ImageCarouselView(work: artist[0].works, imageIndex: 1) { _ in }
    }
}

enum Arrow {
    case next, back, none
}
