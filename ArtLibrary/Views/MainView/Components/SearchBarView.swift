//
//  SearchBarView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

struct SearchBarView: View {
    struct EntryValues {
        static var searchIcon = "magnifyingglass"
        static var placeholder = "Search by name or symbol..."
        static var clearIcon = "xmark.circle.fill"
        static let clearIconOffset: CGFloat = 10
        static let clearIconOpacity: (true: CGFloat, false: CGFloat) = (0,1)
        static let textFieldCorner: CGFloat = 25
        static let textFieldBorder: CGFloat = 2
        static let textFieldPadding: CGFloat = 10
    }
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: EntryValues.searchIcon)
                .foregroundColor(
                    searchText.isEmpty ? .black : .gray
                )
            TextField(EntryValues.placeholder, text: $searchText)
                .foregroundColor(.black)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: EntryValues.clearIcon)
                        .padding()
                        .offset(x: EntryValues.clearIconOffset)
                        .foregroundColor(.black)
                        .opacity(
                            searchText.isEmpty
                            ? EntryValues.clearIconOpacity.true
                            : EntryValues.clearIconOpacity.false
                        )
                        .onTapGesture {
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: EntryValues.textFieldCorner)
                .strokeBorder(
                    Color.gray,
                    lineWidth: EntryValues.textFieldBorder
                )
        )
        .padding(.horizontal, EntryValues.textFieldPadding)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}

