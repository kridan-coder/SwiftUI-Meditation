//
//  WelcomeScreen.swift
//  Meditation
//
//  Created by Developer on 12.01.2022.
//

import SwiftUI

struct WelcomeView: View {
  @Binding var isLoggedIn: Bool
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Image(.background)
          .resizable()
          .ignoresSafeArea()
        VStack {
          Spacer()
          Spacer()
          Image(.logo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height / 3.5)
          Spacer()
          makeTextContainer()
            .foregroundColor(.white)
          Spacer()
          makeButtonsContainer(parentWidth: geometry.size.width)
          Spacer()
        }
      }
    }
  }
  
  @ViewBuilder
  private func makeTextContainer() -> some View {
    Text("Привет".unlocalized)
      .textCase(.uppercase)
      .font(.boldLargeTitle2)
    Text("Наслаждайся отборочными. \nБудь внимателен. \nДелай хорошо.".unlocalized)
      .multilineTextAlignment(.center)
      .font(.mediumBody)
  }
  
  @ViewBuilder
  private func makeButtonsContainer(parentWidth: CGFloat) -> some View {
    NavigationLink {
      LoginView(loginViewModel: LoginViewModel(), isLoggedIn: $isLoggedIn)
        .navigationBarHidden(true)
    } label: {
      CustomButtonView(text: "Войти в аккаунт".unlocalized)
    }
    .frame(width: parentWidth * 0.9, height: 65)
    
    HStack(alignment: .center) {
      Text("Еще нет аккаунта?".unlocalized)
        .font(.mediumBody)
        .minimumScaleFactor(0.5)
        .lineLimit(1)
      NavigationLink {
        RegisterView()
      } label: {
        Text("Зарегистрируйтесь".unlocalized)
          .font(.boldBody)
          .minimumScaleFactor(0.5)
          .lineLimit(1)
        
      }
      
    }
    .foregroundColor(.white)
    .frame(width: parentWidth * 0.9)
  }
  
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView(isLoggedIn: .constant(false))
  }
}
