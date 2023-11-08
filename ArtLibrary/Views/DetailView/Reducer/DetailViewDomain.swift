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
        var step: Arrow = .none
    }
    
    enum Action: Equatable {
        case selectImage(Int?)
        case nextStepImage(Arrow)
        case _updateIndex
    }
    
    func reduce(_ state: inout State, _ action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case let .selectImage(index):
            state.selectedImage = index
            
        case let .nextStepImage(step):
            state.step = step
            return Just(._updateIndex).eraseToAnyPublisher()
            
        case ._updateIndex:
            guard let index = state.selectedImage else { return Empty().eraseToAnyPublisher() }
            switch state.step {
            case .next:
                state.selectedImage = min(state.bio.works.count - 1, index + 1)
            case .back:
                state.selectedImage = max(0, index - 1)
            case .none:
                return Empty().eraseToAnyPublisher()
            }
        }
        return Empty().eraseToAnyPublisher()
    }
    
    static let liveStore = Store(state: Self.State(), reducer: Self())
    
}
