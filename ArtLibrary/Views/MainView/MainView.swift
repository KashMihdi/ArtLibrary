//
//  MainView.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vm: StoreOf<MainViewDomain>
    
    var body: some View {
        NavigationStack {
            SearchBarView(searchText: searchBinding(vm.searchText))
            
            ScrollView(showsIndicators: false) {
                ForEach(vm.artists) { bio in
                    NavigationLink {
                        DetailView(bio: bio)
                    } label: {
                        ArtistItem(artist: bio)
                    }
                }
            }
            .navigationTitle("Art Library")
            .onAppear { vm.send(.viewAppeared) }
        }
    }
    
    init(state: MainViewDomain.State) {
        let initialState = Store(state: state, reducer: MainViewDomain())
        _vm = StateObject(wrappedValue: initialState)
    }
    
    init(store: StoreOf<MainViewDomain> = MainViewDomain.liveStore) {
        _vm = StateObject(wrappedValue: store)
    }
}

private extension MainView {
    func searchBinding(_ text: String) -> Binding<String> {
        .init(
            get: { text },
            set: { vm.send(.searchArtists($0))})
    }
    
    func showDetailBinding(_ value: Bool) -> Binding<Bool> {
        .init(
            get: { value },
            set: { vm.send(.showDetailView($0)) })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
