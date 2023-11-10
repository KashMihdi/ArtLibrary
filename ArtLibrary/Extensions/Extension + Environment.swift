//
//  Extension + Environment.swift
//  ArtLibrary
//
//  Created by Kasharin Mikhail on 07.11.2023.
//

import SwiftUI

private struct OrientationKey: EnvironmentKey {
    static let defaultValue: UIDeviceOrientation = UIDevice.current.orientation
}

extension EnvironmentValues {
  var changeOrientation: UIDeviceOrientation {
    get { self[OrientationKey.self] }
    set { self[OrientationKey.self] = newValue }
  }
}
