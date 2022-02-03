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
  @Binding var currentTabbarView: TabbarViewScreen
  
  init(currentTabbarView: Binding<TabbarViewScreen>) {
    _currentTabbarView = currentTabbarView
    configureTabBar()
  }
  
  var body: some View {
    TabView(selection: $currentTabbarView) {
      MainView(viewModel: MainViewModel())
        .tabItem {
          if currentTabbarView == .home {
            Image(.homeChosen)
          } else {
            Image(.home)
          }
        }.tag(TabbarViewScreen.home)
      
      MainView(viewModel: MainViewModel())
        .tabItem {
          Image(.sound)
        }.tag(TabbarViewScreen.sound)
      
      ProfileView()
        .tabItem {
          if currentTabbarView == .profile {
            Image(.profileChosen)
          } else {
            Image(.profile)
          }
        }.tag(TabbarViewScreen.profile)
      
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
    TabbarView(currentTabbarView: .constant(.home))
  }
}
