//
//  Extension + PreviewProvider.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 11.11.2023.
//

import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() {}
    
    let bios: [Bio] = Bundle.decode(.artists)
    
    var bio: Bio {
        bios.randomElement()!
    }
    
    var works: [Work] {
        bio.works
    }
    
    var work: Work {
        works.randomElement()!
    }
}
