//
//  ContentView.swift
//  Meditation
//
//  Created by Developer on 12.01.2022.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("isAuthorized") var isAuthorized: Bool?
  var body: some View {
    if isAuthorized ?? false {
      CustomTabView()
    } else {
      WelcomeView()
    }
    
  }
}

struct CustomTabView: View {
  @State private var selection = 0
  
  init() {
    UITabBar.appearance().barTintColor = .clear
    let appearance = UITabBar().standardAppearance
    appearance.backgroundColor = UIColor(named: "BackgroundColor")
    appearance.shadowImage = nil
    appearance.shadowColor = nil
    UITabBar.appearance().scrollEdgeAppearance = appearance
    UITabBar.appearance().standardAppearance = appearance
  }
  
  var body: some View {
    TabView(selection: $selection) {
      MainView()
        .tabItem {
          if selection == 0
          {
            Image("HomeChosen")
          } else {
            Image("Home")
          }
        }.tag(0)
      
      MainView()
        .tabItem {
          Image("Sound")
        }.tag(1)
      
      ProfileView()
        .tabItem {
          if selection == 2
          {
            Image("ProfileChosen")
          } else {
            Image("Profile")
          }
        }.tag(2)
      
      
    }
    .background(Color.clear)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    CustomTabView()
  }
}
