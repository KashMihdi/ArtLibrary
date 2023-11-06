//
//  MainViewDomain.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import Foundation
import Combine

struct MainViewDomain: ReducerProtocol {
    
    //MARK: - State
    struct State {
        var artists: [Bio] = .init()
        var searchArtists: [Bio] = .init()
        var searchText: String = .init()
        var showDetail: Bool = .init(false)
    }
    
    //MARK: - Action
    enum Action {
        case viewAppeared
        case searchArtists(String)
        case _filteredData(String)
        case showDetailView(Bool)
    }
    
    //MARK: - Dependencies
    let dataBundle: [Bio]
    
    init(dataBundle: [Bio] = Bundle.decode(.artists)) {
        self.dataBundle = dataBundle
    }

    //MARK: - Reducer
    func reduce(_ state: inout State, _ action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case .viewAppeared:
            state.artists = dataBundle

        case let .searchArtists(word):
            state.searchText = word
            return word.isEmpty
                ? Just(.viewAppeared).eraseToAnyPublisher()
                : Just(._filteredData(word)).eraseToAnyPublisher()
            
        case let ._filteredData(word):
            state.artists = dataBundle.filter { $0.name.contains(word) }
            
        case let .showDetailView(showDetail):
            state.showDetail = showDetail
        }
        return Empty().eraseToAnyPublisher()
    }
    
    //MARK: - Live store
    static let liveStore = Store(state: Self.State(), reducer: Self())
}
