//
//  CloseButtonItem.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 11.11.2023.
//

import SwiftUI

struct CloseButtonItem: View {
    struct EntryValues {
        static let imageName = "xmark"
        static let imagePaddingTop: CGFloat = 30
        static let imagePaddingTrailing: CGFloat = 35
    }
    
    @Binding var step: Arrow
    let completion: (Arrow) -> ()
    
    var body: some View {
        Image(systemName: EntryValues.imageName)
            .font(.title)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, EntryValues.imagePaddingTop)
            .padding(.trailing, EntryValues.imagePaddingTrailing)
            .onTapGesture {
                step = .none
                completion(step)
            }
    }
}

struct CloseButtonItem_Previews: PreviewProvider {
    static var previews: some View {
        CloseButtonItem(step: .constant(.none), completion: { _ in })
    }
}
