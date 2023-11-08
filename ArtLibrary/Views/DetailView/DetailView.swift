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
            VStack(spacing: 40) {
                ArtGridView(oversize: indexGridBinding(), works: vm.bio.works)
                Spacer()
            }
            .padding(.top, 20)
            .navigationBarBackButtonHidden(true)
        }
        .safeAreaInset(edge: .top) {
            HeaderDetailView(artist: vm.bio)
        }
        .overlay(
            ImageCarouselView(work: vm.bio.works, step: stepBinding(), imageIndex: indexGridBinding())
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

private extension DetailView {
    func indexGridBinding() -> Binding<Int?> {
        .init(
            get: { vm.selectedImage },
            set: { vm.send(.selectImage($0)) })
    }
    
    func stepBinding() -> Binding<Arrow> {
        .init(
            get: { vm.step },
            set: { vm.send(.nextStepImage($0))})
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
