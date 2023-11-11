//
//  DetailView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var vm: StoreOf<DetailViewDomain>
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ArtGridView(works: vm.bio.works) { vm.send(.selectImage($0)) }
                .padding([.top, .bottom], 20)
        }
        .navigationBarBackButtonHidden(true)
        .safeAreaInset(edge: .top) {
            HeaderDetailView(artist: vm.bio)
        }
        .overlay(
            ImageCarouselView(
                work: vm.bio.works,
                imageIndex: vm.selectedImage
            ) { vm.send(.nextStepImage($0)) }
        )
        .animation(.linear(duration: 0.4), value: vm.selectedImage)
        .ignoresSafeArea()
    }
    
    init(bio: Bio = .init()) {
        var instance = DetailViewDomain.State()
        instance.bio = bio
        let initialState = Store(state: instance, reducer: DetailViewDomain())
        _vm = StateObject(wrappedValue: initialState)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(bio: dev.bio)
        }
    }
}
