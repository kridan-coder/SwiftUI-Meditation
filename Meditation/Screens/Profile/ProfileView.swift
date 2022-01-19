//
//  ProfileView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 19.01.2022.
//


import SwiftUI
import Kingfisher

class ProfileViewModel: ObservableObject {
  @Published var name = "Daniel"
}

struct ProfileView: View {
  @AppStorage("isAuthorized") var isAuthorized: Bool?
  @AppStorage("wasLoggedOut") var wasLoggedOut: Bool?
  
  var isNavigationBarHidden = true
  
  @StateObject var viewModel = ProfileViewModel()
  
  var body: some View {
    NavigationView {
      GeometryReader { screen in
        ZStack {
          Color("BackgroundColor")
            .ignoresSafeArea()
          
          VStack {
            HStack(alignment: .center) {
              Image("Hamburger")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
              
              Spacer()
              Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
              Spacer()
            
              Button("exit") {
                isAuthorized = false
                withAnimation {
                  wasLoggedOut = true
                }
                
              }
              .font(.custom("Alegreya-Regular", size: 23))
              .foregroundColor(.white)
              
            }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
          }
        }
      }
    }
    .navigationBarHidden(isNavigationBarHidden)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

