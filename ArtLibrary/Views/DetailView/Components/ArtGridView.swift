//
//  ArtGridView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

struct ArtGridView: View {
    struct EntryValues {
        static let gridSpacing: CGSize = .init(width: 20, height: 20)
        static let imageFrame: CGFloat = 150
        static let imageOverlayOpacity: CGFloat = 0.3
        static let itemShadow: (opacity: CGFloat, radius: CGFloat, y: CGFloat) = (0.2, 5, 5)
        static let clipRadius: CGFloat = 20
        static let stackPadding: CGFloat = 8
    }
    
    @Environment(\.changeOrientation) var orientation
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var column = 1
    let works: [Work]
    let completion: (Work) -> ()
    
    var body: some View {
        let gridLayout = Array(
            repeating:
                GridItem(.flexible(), spacing:EntryValues.gridSpacing.width),
            count: column)
        LazyVGrid(columns: gridLayout, spacing: EntryValues.gridSpacing.height) {
            ForEach(works, id: \.image) { work in
                ZStack {
                    Image(work.image)
                        .resizable()
                        .frame(height: EntryValues.imageFrame)
                        .overlay(
                            Color.black.opacity(
                                EntryValues.imageOverlayOpacity
                            )
                        )
                    
                    Text(work.title)
                        .foregroundColor(.white)
                        .font(.title.bold())
                }
                .onTapGesture {
                    completion(work)
                }
                .shadow(
                    color: .black.opacity(EntryValues.itemShadow.opacity),
                    radius: EntryValues.itemShadow.radius,
                    y: EntryValues.itemShadow.y
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: EntryValues.clipRadius)
                )
            }
        }
        /// with custom Environment
        //.onAppear{ checkOrientation(orientation)}
        //.onRotate(perform: checkOrientation(_:))
        .onAppear{ checkOrientation(verticalSizeClass)}
        .onChange(of: verticalSizeClass, perform: checkOrientation(_:))
        .padding(.horizontal, EntryValues.stackPadding)
    }
}

private extension ArtGridView {
    func checkOrientation(_ orientation: UIDeviceOrientation) {
        switch orientation {
        case .portrait, .unknown:  column = 1
        default: column = 2
        }
    }
    func checkOrientation(_ orientation: UserInterfaceSizeClass?) {
        switch orientation {
        case .regular:  column = 1
        default: column = 2
        }
    }
}

struct ArtGridView_Previews: PreviewProvider {
    static var previews: some View {
        ArtGridView(works: dev.works) { _ in }
    }
}
