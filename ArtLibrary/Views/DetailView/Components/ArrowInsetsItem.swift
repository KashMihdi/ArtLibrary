//
//  ArrowInsetsItem.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 11.11.2023.
//

import SwiftUI

struct ArrowInsetsItem<Content: View>: View {
    @Binding var step: Arrow
    let imageIndex: Int
    let lastIndex: Int
    let completion: (Arrow) -> ()
    let content: Content
    
    init(
        step: Binding<Arrow>,
        imageIndex: Int,
        lastIndex: Int,
        completion: @escaping (Arrow) -> Void,
        @ViewBuilder content: () -> Content
    ){
        self._step = step
        self.imageIndex = imageIndex
        self.lastIndex = lastIndex
        self.completion = completion
        self.content = content()
    }
    
    var body: some View {
        HStack(spacing: 40) {
            HStack {
                Image(systemName: "arrow.left")
                Text("Back")
            }
            .opacity(imageIndex == 0 ? 0 : 1)
            .onTapGesture {
                step = .back
                completion(step)
            }
            
            content
            
            HStack {
                Text("Next")
                Image(systemName: "arrow.right")
            }
            .opacity(imageIndex == (lastIndex - 1) ? 0 : 1)
            .onTapGesture {
                step = .next
                completion(step)
            }
        }
    }
}

struct ArrowInsetsItem_Previews: PreviewProvider {
    static var previews: some View {
        ArrowInsetsItem(step: .constant(.none), imageIndex: 3, lastIndex: 3, completion: { _ in }, content: { })
    }
}
