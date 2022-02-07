//
//  ContentView.swift
//  Meditation
//

import SwiftUI

final class ContentViewModel: ObservableObject {
  @Environment(\.appDependencies) private var dependencies
  @Published var hadFirstRunAlready: Bool = false
  @Published var isLoggedIn: Bool = false
  
  func onAppear() {
    hadFirstRunAlready = dependencies.userDataStorageService.hadFirstRunAlready
    isLoggedIn = dependencies.userDataStorageService.isLoggedIn
    dependencies.userDataStorageService.hadFirstRunAlready = true
  }
  
}

struct ContentView: View {
  @ObservedObject private(set) var viewModel: ContentViewModel
  @State private var currentTabbarView: TabbarViewScreen = .profile
  var body: some View {
    NavigationView {
      if viewModel.isLoggedIn {
        TabbarView(currentTabbarView: $currentTabbarView,
                   viewModel: TabbarViewModel(isLoggedIn: $viewModel.isLoggedIn,
                                              mainViewModel: MainViewModel(),
                                              profileViewModel: ProfileViewModel(isLoggedIn: $viewModel.isLoggedIn)))
      } else {
        if viewModel.hadFirstRunAlready {
          LoginView(viewModel: LoginViewModel(isLoggedIn: $viewModel.isLoggedIn))
        } else {
          WelcomeView(isLoggedIn: $viewModel.isLoggedIn)
        }
      }
    }
    .navigationBarHidden(true)
    .navigationBarTitle("")
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
