//
//  LoginScreen.swift
//  Meditation
//
//  Created by Developer on 12.01.2022.
//

import SwiftUI

class LoginViewModel: ObservableObject {
  @Published var email: String = ""
  @Published var password: String = ""
  
  var isValidatedCorrectly: Bool {
    email.contains("@") && !password.isEmpty
  }
  
  func logIn() {
    MainView()
  }
  
}

struct LoginScreen: View {
  
  @Environment(\.editMode) var editMode
  
  @StateObject var loginViewModel = LoginViewModel()
  
  var body: some View {
    NavigationView {
      GeometryReader { screen in
        ZStack {
          Color("BackgroundColor")
            .ignoresSafeArea()
          
          
          VStack(alignment: .leading) {
            Image("Logo")
              .resizable()
              .scaledToFit()
              .frame(width: 60, height: 60)
            
            Spacer()
            
            Text("Sign In")
              .font(.custom("Alegreya-Medium", size: 35))
              .foregroundColor(.white)
            Spacer()
            Spacer()
            Group {
              TextField("", text: $loginViewModel.email)
                .placeholder(when: loginViewModel.email.isEmpty) {
                  Text("Email").foregroundColor(.gray)
                }
                .foregroundColor(.white)
                .font(.custom("Alegreya-Regular", size: 20))
                .frame(width: screen.size.width * 0.9)
                .overlay(alignment: .bottom) {
                  GeometryReader { textField in
                    Rectangle()
                      .fill(Color("SecondaryColor"))
                      .frame(width: textField.size.width + 10, height: 1, alignment: .center)
                      .offset(x: -5, y: textField.size.height + 5)
                  }
                }
              Spacer()
              SecureField("", text: $loginViewModel.password)
                .placeholder(when: loginViewModel.password.isEmpty) {
                  Text("Пароль").foregroundColor(.gray)
                }
                .foregroundColor(.white)
                .font(.custom("Alegreya-Regular", size: 20))
                .frame(width: screen.size.width * 0.9)
                .overlay(alignment: .bottom) {
                  GeometryReader { textField in
                    Rectangle()
                      .fill(Color("SecondaryColor"))
                      .frame(width: textField.size.width + 10, height: 1, alignment: .center)
                      .offset(x: -5, y: textField.size.height + 5)
                  }
                }
            }
            
            Spacer()
            Group {
              NavigationLink {
                MainView()
              } label: {
                CustomButtonView(text: "Sign In")
                  .frame(width: screen.size.width * 0.9, height: 60)
              }
              Spacer()
              NavigationLink {
                RegisterScreen()
              } label: {
                CustomButtonView(text: "Sign Up")
                  .frame(width: screen.size.width * 0.9, height: 60)
                  .frame(width: screen.size.width * 0.9, height: 60)
              }
            }
            Spacer()
            Spacer()
          }
          
        }
        .overlay(alignment: .bottom) {
          Image("Leafs")
            .resizable()
            .scaledToFit()
            .allowsHitTesting(false)
          
        }
        .ignoresSafeArea(edges: .bottom)
      }
      
    }
    .navigationBarHidden(true)
    
    
  }
}

struct LoginScreen_Previews: PreviewProvider {
  static var previews: some View {
    LoginScreen()
  }
}
