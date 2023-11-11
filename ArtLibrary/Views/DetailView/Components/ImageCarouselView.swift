//
//  ImageCarouselView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 07.11.2023.
//

import SwiftUI

struct ImageCarouselView: View {
    struct EntryValues {
        static let stackSpacing: CGFloat = 40
        static let insetsItemPadding: CGFloat = 20
    }
    
    @State private var step: Arrow = .none
    let work: [Work]
    var imageIndex: Int?
    let completion: (Arrow) -> ()
    
    var body: some View {
        if let imageIndex {
            VStack(spacing: EntryValues.stackSpacing) {
                CarouselItem(work: work, imageIndex: imageIndex)
            }
            .safeAreaInset(edge: .bottom) {
                ArrowInsetsItem(
                    step: $step,
                    imageIndex: imageIndex,
                    lastIndex: work.endIndex,
                    completion: completion
                ) {
                    Text("\(imageIndex + 1) / \(work.count)")
                }
                .animation(nil, value: imageIndex)
                .padding()
                .padding(.bottom, EntryValues.insetsItemPadding)
            }
            .safeAreaInset(edge: .top) {
                CloseButtonItem(step: $step, completion: completion)
            }
            .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .background(.ultraThinMaterial)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ImageCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCarouselView(work: dev.works, imageIndex: 2) { _ in }
    }
}

enum Arrow {
    case next, back, none
}
