//
//  DetailViewDomain.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import Foundation
import Combine

struct DetailViewDomain: ReducerProtocol {
    
    struct State {
        var bio: Bio = .init()
        var selectedImage: Int? = nil
        var work: Work? = nil
    }
    
    enum Action {
        case selectImage(Int?)
        case _updateWork
    }
    
    func reduce(_ state: inout State, _ action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case let .selectImage(index):
            state.selectedImage = index
            return Just(._updateWork).eraseToAnyPublisher()
    
        case ._updateWork:
            if let index = state.selectedImage {
                state.work = state.bio.works[index]
                return Empty().eraseToAnyPublisher()
            }
            state.work = nil
            
        }
        return Empty().eraseToAnyPublisher()
    }
    
    static let liveStore = Store(state: Self.State(), reducer: Self())
    
}
