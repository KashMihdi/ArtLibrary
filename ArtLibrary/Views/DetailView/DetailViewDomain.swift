//
//  DetailViewDomain.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import Foundation
import Combine

struct DetailViewDomain: ReducerProtocol {
    
    typealias State = Bio
    
    enum Action {
        case viewAppeared
    }
    
    func reduce(_ state: inout Bio, _ action: Action) -> AnyPublisher<Action, Never> {
        switch action {
        case .viewAppeared: return Empty().eraseToAnyPublisher()
            
        return Empty().eraseToAnyPublisher()
        }
    }
    
    static let liveStore = Store(state: Self.State(), reducer: Self())
    
}
