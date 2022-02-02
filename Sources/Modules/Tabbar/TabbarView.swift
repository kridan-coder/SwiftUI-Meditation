//
//  TabbarView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 02.02.2022.
//

import SwiftUI

enum TabbarCurrentView: String {
  case home, sound, profile
}

struct TabbarView: View {
  @Binding var currentTabbarView: TabbarCurrentView
  
  init(currentTabbarView: Binding<TabbarCurrentView>) {
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
        }.tag(TabbarCurrentView.home)
      
      MainView(viewModel: MainViewModel())
        .tabItem {
          Image(.sound)
        }.tag(TabbarCurrentView.sound)
      
      ProfileView()
        .tabItem {
          if currentTabbarView == .profile {
            Image(.profileChosen)
          } else {
            Image(.profile)
          }
        }.tag(TabbarCurrentView.profile)
      
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
