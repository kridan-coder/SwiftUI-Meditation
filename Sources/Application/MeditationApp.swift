//
//  MeditationApp.swift
//  Meditation
//
//  Created by Developer on 12.01.2022.
//

import SwiftUI

@main
struct MeditationApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel())
        }
    }
}
