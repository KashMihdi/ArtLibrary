//
//  ReducerProtocol.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import Foundation
import Combine

protocol ReducerProtocol<State, Action> {
    associatedtype State
    associatedtype Action
    
    func reduce(_ state: inout State, _ action: Action) -> AnyPublisher<Action, Never>
}
