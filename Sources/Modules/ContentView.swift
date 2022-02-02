//
//  ContentView.swift
//  Meditation
//
//  Created by Developer on 12.01.2022.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
  @Environment(\.appDependencies) private var dependencies
  @Published var hadFirstRunAlready: Bool = false
  
  func onAppear() {
    hadFirstRunAlready = dependencies.userDataStorageService.hadFirstRunAlready
  }
}

struct ContentView: View {
  @ObservedObject private(set) var viewModel: ContentViewModel
  
  var body: some View {
    NavigationView {
      if viewModel.hadFirstRunAlready {
        LoginView(loginViewModel: LoginViewModel())
      } else {
        WelcomeView()
      }
    }
    .onAppear {
      viewModel.onAppear()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: ContentViewModel())
  }
}
