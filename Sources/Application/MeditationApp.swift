//
//  MeditationApp.swift
//  Meditation
//

import SwiftUI

@main
struct MeditationApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(viewModel: ContentViewModel())
    }
  }
}
