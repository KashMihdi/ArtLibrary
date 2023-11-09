//
//  AdaptiveView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

struct AdaptiveView<Content: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geo in
            if geo.size.width > geo.size.height {
                content
                    .clipShape(Circle())
            } else {
                content
            }
        }
    }
}

struct AdaptiveView_Previews: PreviewProvider {
    static var previews: some View {
        let artist: [Bio] = Bundle.decode(.artists)
        AdaptiveView {
            HeaderDetailView(artist: artist[0])
        }
    }
}
