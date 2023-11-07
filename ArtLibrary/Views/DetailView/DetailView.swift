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
                HeaderDetailView(artist: vm.state)
                ArtGridView(works: vm.works)
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
        .ignoresSafeArea()
    }
    
    init(bio: Bio = .init()) {
        let initialState = Store(state: bio, reducer: DetailViewDomain())
        _vm = StateObject(wrappedValue: initialState)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let artist: [Bio] = Bundle.decode(.artists)
        NavigationStack {
            DetailView(bio: artist[3])
        }
    }
}
