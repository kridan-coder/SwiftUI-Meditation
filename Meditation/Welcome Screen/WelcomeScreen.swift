//
//  WelcomeScreen.swift
//  Meditation
//
//  Created by Developer on 12.01.2022.
//

import SwiftUI

struct WelcomeScreen: View {
  var body: some View {
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
              LoginScreen()
            } label: {
              Button("Войти в аккаунт") {}
            }
            .buttonStyle(CustomButtonStyle())
            .frame(width: geometry.size.width * 0.9, height: 65)
            
            HStack(alignment: .center) {
              Text("Еще нет аккаунта?")
                .font(.custom("Alegreya-Medium", size: 20))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
              NavigationLink {
                RegisterScreen()
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

struct WelcomeScreen_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeScreen()
  }
}
