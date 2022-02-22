//
//  TabbarView.swift
//  Meditation
//

import SwiftUI
import CoreData

enum TabbarViewScreen: String {
  case home, sound, profile
}

final class TabbarViewModel: ObservableObject {
  @ObservedObject var mainViewModel: MainViewModel
  @ObservedObject var profileViewModel: ProfileViewModel
  
  @Binding var isLoggedIn: Bool
  
  var coreDataViewContext: NSManagedObjectContext {
    dependencies.coreDataService.viewContext
  }
  
  @Environment(\.appDependencies) private var dependencies
  
  init(isLoggedIn: Binding<Bool>,
       mainViewModel: MainViewModel,
       profileViewModel: ProfileViewModel) {
    _isLoggedIn = isLoggedIn
    self.mainViewModel = mainViewModel
    self.profileViewModel = profileViewModel
  }
  
}

struct TabbarView: View {
  @Binding var currentTabbarView: TabbarViewScreen
  
  @ObservedObject private(set) var viewModel: TabbarViewModel
  
  init(currentTabbarView: Binding<TabbarViewScreen>, viewModel: TabbarViewModel) {
    _currentTabbarView = currentTabbarView
    self.viewModel = viewModel
    configureTabBar()
  }
  
  var body: some View {
    TabView(selection: $currentTabbarView) {
      MainView(viewModel: viewModel.mainViewModel)
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
      
      ProfileView(viewModel: viewModel.profileViewModel)
        .environment(\.managedObjectContext, viewModel.coreDataViewContext)
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
    TabbarView(currentTabbarView: .constant(.home),
               viewModel: TabbarViewModel(isLoggedIn: .constant(false),
                                          mainViewModel: MainViewModel(),
                                          profileViewModel: ProfileViewModel(isLoggedIn: .constant(false))))
  }
}
