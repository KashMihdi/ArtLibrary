//
//  Artist.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import Foundation

struct Bio: Decodable, Identifiable {
    let name: String
    let bio: String
    let image: String
    let works: [Work]
    
    var id: Int {
        name.hashValue
    }
    
    init(
        name: String = .init(),
        bio: String  = .init(),
        image: String = .init(),
        works: [Work] = .init()
    ) {
        self.name = name
        self.bio = bio
        self.image = image
        self.works = works
    }
}

struct Work: Decodable, Equatable {
    let title: String
    let image: String
    let info: String
}
