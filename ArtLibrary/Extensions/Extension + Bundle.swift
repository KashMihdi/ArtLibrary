//
//  Extension + Bundle.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import Foundation
extension Bundle {
    
    static func decode<T: Decodable>(_ file: FileName) -> T {
        guard let url = self.main.url(forResource: file.rawValue, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    }
    
    enum FileName: String {
        case artists = "artists.json"
    }
    
}
