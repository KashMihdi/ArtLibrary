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
}

struct Work: Decodable {
    let title: String
    let image: String
    let info: String
}
