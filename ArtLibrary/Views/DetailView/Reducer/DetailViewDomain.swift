//
//  DetailViewDomain.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import Foundation
import Combine

struct DetailViewDomain: ReducerProtocol {
    
    //MARK: - State
    struct State {
        var bio: Bio = .init()
        var selectedImage: Int? = nil
        var step: Arrow = .none
    }
    
    //MARK: - Action
    enum Action: Equatable {
        case selectImage(Work)
        case nextStepImage(Arrow)
        case _updateIndex
    }
    
    //MARK: - Reducer
    func reduce(_ state: inout State, _ action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case let .selectImage(work):
            state.selectedImage = state.bio.works.firstIndex(of: work)
            
        case let .nextStepImage(step):
            state.step = step
            return Just(._updateIndex).eraseToAnyPublisher()
            
        case ._updateIndex:
            guard let index = state.selectedImage else { break }
            switch state.step {
            case .next:
                state.selectedImage = min(state.bio.works.count - 1, index + 1)
            case .back:
                state.selectedImage = max(0, index - 1)
            case .none:
                state.selectedImage = nil
            }
        }
        return Empty().eraseToAnyPublisher()
    }
    
    //MARK: - Live Store
    static let liveStore = Store(state: Self.State(), reducer: Self())
    
}
