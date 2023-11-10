//
//  ArtLibraryApp.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 06.11.2023.
//

import SwiftUI

@main
struct ArtLibraryApp: App {
    @State private var orientation: UIDeviceOrientation = .portrait
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.changeOrientation, orientation)
                .onRotate { newPosition in
                    orientation = newPosition
                }
        }
    }
}
