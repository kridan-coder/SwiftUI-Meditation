//
//  WelcomeScreen.swift
//  Meditation
//
//  Created by Developer on 12.01.2022.
//

import SwiftUI

struct WelcomeView: View {
  
  @AppStorage("wasLoggedOut") var wasLoggedOut: Bool?
  
  var body: some View {
    if wasLoggedOut ?? false {
      LoginView()
    } else {
      GeometryReader { geometry in
        NavigationView {
          ZStack {
            Image("Background")
              .resizable()
              .ignoresSafeArea()
            
            VStack {
              Spacer()
              
              Spacer()
              
              Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height / 3.5)
              
              Text("Привет")
                .textCase(.uppercase)
                .font(.custom("Alegreya-Bold", size: 40))
                .foregroundColor(.white)
              Text("Наслаждайся отборочными. \nБудь внимателен. \nДелай хорошо.")
                .multilineTextAlignment(.center)
                .font(.custom("Alegreya-Medium", size: 20))
                .foregroundColor(.white)
              Spacer()
              
              Spacer()
              NavigationLink {
                LoginView()
              } label: {
                CustomButtonView(text: "Войти в аккаунт")
              }
              .frame(width: geometry.size.width * 0.9, height: 65)
              
              HStack(alignment: .center) {
                Text("Еще нет аккаунта?")
                  .font(.custom("Alegreya-Medium", size: 20))
                  .minimumScaleFactor(0.5)
                  .lineLimit(1)
                NavigationLink {
                  RegisterView()
                } label : {
                  Text("Зарегистрируйтесь")
                    .font(.custom("Alegreya-Bold", size: 20))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                  
                }
                
              }
              .foregroundColor(.white)
              .frame(width: geometry.size.width * 0.9)
              
              Spacer()
            }
          }
        }
        
      }
      
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
