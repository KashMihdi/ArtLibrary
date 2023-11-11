//
//  HeaderDetailView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

struct HeaderDetailView: View {
    struct EntryValues {
        static let imageFrame: (true: CGFloat, false: CGFloat) = (150, 250)
        static let imageOpacity: CGFloat = 0.5
        static let textColor: (true: Color, false: Color) = (.black, .white)
        static let textPadding: CGFloat = 40
        static let globalFrameW: (true: CGFloat, false: CGFloat) = (200, 250)
    }

    @State private var changedOrientation = false
    @Environment(\.changeOrientation) var orientation
    @Environment(\.dismiss) var dismiss
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    let artist: Bio
    
    var body: some View {
        AnyLayout(changedOrientation
                  ? AnyLayout(HStackLayout())
                  : AnyLayout(ZStackLayout(alignment: .bottomTrailing))) {
            Image(artist.image)
                .resizable()
                .aspectRatio(contentMode: changedOrientation ? .fit : .fill)
                .frame(maxHeight: changedOrientation
                       ? EntryValues.imageFrame.true
                       : EntryValues.imageFrame.false
                )
                .overlay(Color.black.opacity(EntryValues.imageOpacity))
                .clipShape(changedOrientation
                           ? AnyShape(Circle())
                           : AnyShape(Rectangle())
                )
            
            VStack {
                Text(artist.name)
                    .font(.title.bold())
                    .foregroundColor(
                        changedOrientation
                            ? EntryValues.textColor.true
                            : EntryValues.textColor.false
                    )
                    .padding(.horizontal, EntryValues.textPadding)
                if changedOrientation {
                    Text(artist.bio)
                        .foregroundColor(.black)
                }
            }
        }
        .overlay(
            Image(systemName: "arrow.left")
                .font(.title.bold())
                .foregroundColor(changedOrientation ? .black : .white)
                .padding(.leading, 20)
                .onTapGesture {
                    dismiss()
                }
            , alignment: changedOrientation ? .topTrailing : .bottomLeading
        )
        /// with custom Environment
        //.onAppear { checkOrientation(orientation) }
        //.onChange(of: orientation, perform: checkOrientation(_:))
        .onAppear { checkOrientation(verticalSizeClass!)}
        .animation(.linear, value: changedOrientation)
        .frame(
            maxWidth: .infinity,
            maxHeight:
                changedOrientation
                    ? EntryValues.globalFrameW.true
                    : EntryValues.globalFrameW.false,
                alignment: .leading
        )
        .background(
            Color.white
                .shadow(color: .black, radius: 10, y: 5)
                .ignoresSafeArea()
        )
        .onChange(of: verticalSizeClass!, perform: checkOrientation(_:))
        .animation(.linear, value: changedOrientation)
    }
}

private extension HeaderDetailView {
    func checkOrientation(_ orientation: UIDeviceOrientation) {
        switch orientation {
        case .portrait, .unknown: changedOrientation = false
        default: changedOrientation = true
        }
    }
    
    func checkOrientation(_ orientation: UserInterfaceSizeClass) {
        switch orientation {
        case .regular: changedOrientation = false
        default: changedOrientation = true
        }
    }
}

struct HeaderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderDetailView(artist: dev.bio)
    }
}

