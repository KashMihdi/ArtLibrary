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
        var step: Arrow = .none
    }
    
    enum Action: Equatable {
        case selectImage(Int?)
        case _updateWork
        case nextStepImage(Arrow)
        case _updateIndex
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
            
        case let .nextStepImage(step):
            state.step = step
            return Just(._updateIndex).eraseToAnyPublisher()
        case ._updateIndex:
            guard let index = state.selectedImage else { return Empty().eraseToAnyPublisher() }
            switch state.step {
            case .next:
                state.selectedImage = min(state.bio.works.count - 1, index + 1)
                return Just(._updateWork).eraseToAnyPublisher()
            case .back:
                state.selectedImage = max(0, index - 1)
                return Just(._updateWork).eraseToAnyPublisher()
            case .none:
                return Empty().eraseToAnyPublisher()
            }
        }
        return Empty().eraseToAnyPublisher()
    }
    
    static let liveStore = Store(state: Self.State(), reducer: Self())
    
}
