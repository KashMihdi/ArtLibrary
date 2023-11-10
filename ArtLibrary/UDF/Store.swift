//
//  Store.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import Foundation
import Combine

typealias StoreOf<R: ReducerProtocol> = Store<R.State, R.Action>

@dynamicMemberLookup
final class Store<State, Action>: ObservableObject{
    @Published private(set) var state: State
    private var reducer: any ReducerProtocol<State, Action>
    private var cancellable = Set<AnyCancellable>()
    
    init<R: ReducerProtocol>(state: R.State, reducer: R) where R.State == State, R.Action == Action {
        self.state = state
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        reducer.reduce(&state, action)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: send)
            .store(in: &cancellable)
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
        state[keyPath: keyPath]
    }
}
