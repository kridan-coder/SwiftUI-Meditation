//
//  TabbarView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 02.02.2022.
//

import SwiftUI

enum TabbarViewScreen: String {
  case home, sound, profile
}

struct TabbarView: View {
  @State var currentTabbarView: TabbarViewScreen = .profile
  @Binding var isLoggedIn: Bool
  
  @StateObject var mainViewModel = MainViewModel()
  @StateObject var profileViewModel = ProfileViewModel()
  
  init(isLoggedIn: Binding<Bool>) {
    _isLoggedIn = isLoggedIn
    configureTabBar()
  }
  
  var body: some View {
    TabView(selection: $currentTabbarView) {
      MainView(viewModel: mainViewModel)
        .tabItem {
          if currentTabbarView == .home {
            Image(.homeChosen)
          } else {
            Image(.home)
          }
        }.tag(TabbarViewScreen.home)
        .navigationBarHidden(true).navigationTitle("")
      
      Rectangle()
        .foregroundColor(.backgroundColor)
        .ignoresSafeArea()
        .tabItem {
          Image(.sound)
        }.tag(TabbarViewScreen.sound)
        .navigationBarHidden(true).navigationTitle("")
      
      ProfileView(isLoggedIn: $isLoggedIn, viewModel: ProfileViewModel())
        .tabItem {
          if currentTabbarView == .profile {
            Image(.profileChosen)
          } else {
            Image(.profile)
          }
        }.tag(TabbarViewScreen.profile)
        .navigationBarHidden(true).navigationTitle("")
    }
    .background(Color.clear)
  }
  
  private func configureTabBar() {
    UITabBar.appearance().barTintColor = .clear
    let appearance = UITabBar().standardAppearance
    appearance.backgroundColor = UIColor(Color.backgroundColor)
    appearance.shadowImage = nil
    appearance.shadowColor = nil
    UITabBar.appearance().scrollEdgeAppearance = appearance
    UITabBar.appearance().standardAppearance = appearance
  }
  
}

struct TabbarView_Previews: PreviewProvider {
  static var previews: some View {
    TabbarView(isLoggedIn: .constant(false))
  }
}
