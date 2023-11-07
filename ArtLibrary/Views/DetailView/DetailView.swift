//
//  DetailView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var vm: StoreOf<DetailViewDomain>
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                HeaderDetailView(artist: vm.bio)
                ArtGridView(oversize: indexGridBinding(), works: vm.bio.works)
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
        .overlay(
            ImageCarouselView(work: selectedWorkBinding())
        )
        .ignoresSafeArea()
    }
    
    init(bio: Bio = .init()) {
        var instance = DetailViewDomain.State()
        instance.bio = bio
        let initialState = Store(state: instance, reducer: DetailViewDomain())
        _vm = StateObject(wrappedValue: initialState)
    }
}

private extension DetailView {
    func indexGridBinding() -> Binding<Int?> {
        .init(
            get: { vm.selectedImage },
            set: { vm.send(.selectImage($0)) })
    }
    
    func selectedWorkBinding() -> Binding<Work?> {
        .init(
            get: { vm.work },
            set: { _ in vm.send(.selectImage(nil)) })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let artist: [Bio] = Bundle.decode(.artists)
        NavigationStack {
            DetailView(bio: artist[0])
        }
    }
}
