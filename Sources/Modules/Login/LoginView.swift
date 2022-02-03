//
//  LoginScreen.swift
//  Meditation
//
//  Created by Developer on 12.01.2022.
//

import SwiftUI
import PromiseKit

class LoginViewModel: ObservableObject {
  @Environment(\.appDependencies) private var dependencies
  
  @Published var isLoggedIn: Bool = false
  @Published var password: String = ""
  @Published var email: String = ""
  
  func onAppear() {
    email = dependencies.userDataStorageService.email ?? ""
    isLoggedIn = dependencies.userDataStorageService.isLoggedIn
  }
  
  var isValidatedCorrectly: Bool {
    email.contains("@") && email.contains(".") && !password.isEmpty
  }
  
  func logIn(showAlert: Binding<Bool>, isLoggedIn: Binding<Bool>) {
    guard isValidatedCorrectly else {
      showAlert.wrappedValue = true
      return
    }
    
    firstly {
      dependencies.authNetworkService.login(email: email, password: password)
    }.done { [self] result in
      dependencies.userDataStorageService.nickname = result.nickName
      dependencies.userDataStorageService.email = result.email
      dependencies.userDataStorageService.avatarURL = result.avatar.absoluteString
      dependencies.userDataStorageService.accessToken = result.token
      isLoggedIn.wrappedValue = true
    }.catch { _ in
      showAlert.wrappedValue = true
    }
  }
  
}

struct LoginView: View {
  @State private var showingAlert = false
  
  @Environment(\.editMode) var editMode
  
  @ObservedObject var loginViewModel: LoginViewModel
  
  @Binding var isLoggedIn: Bool
  
  var body: some View {
    GeometryReader { screen in
      ZStack {
        Color.backgroundColor
          .ignoresSafeArea()
        VStack(alignment: .leading) {
          Image(.logo)
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
          Spacer()
          Text("Sign In".unlocalized)
            .font(.mediumLargeTitle1)
            .foregroundColor(.white)
          Spacer()
          Spacer()
          makeFields(parentWidth: screen.size.width)
          Spacer()
          makeButtons(parentWidth: screen.size.width)
          Spacer()
          Spacer()
        }
      }
    }
    .overlay(alignment: .bottom) {
      Image(.leaves)
        .resizable()
        .scaledToFit()
        .allowsHitTesting(false)
    }
    .ignoresSafeArea(.all, edges: .bottom)
    .alert(R.string.commonErrors.errorUnknownText(), isPresented: $showingAlert) {
      Button("OK".unlocalized, role: .cancel) { }
    }
  }
  
  @ViewBuilder
  private func makeFields(parentWidth: CGFloat) -> some View {
    TextField("", text: $loginViewModel.email)
      .placeholder(when: loginViewModel.email.isEmpty) {
        Text("Email".unlocalized).foregroundColor(.gray)
      }
      .foregroundColor(.white)
      .font(.regularBody)
      .frame(width: parentWidth * 0.9)
      .overlay(alignment: .bottom) {
        GeometryReader { textField in
          Rectangle()
            .fill(Color.secondaryColor)
            .frame(width: textField.size.width + 10, height: 1, alignment: .center)
            .offset(x: -5, y: textField.size.height + 5)
        }
      }
    Spacer()
    SecureField("", text: $loginViewModel.password)
      .placeholder(when: loginViewModel.password.isEmpty) {
        Text("Пароль".unlocalized).foregroundColor(.gray)
      }
      .foregroundColor(.white)
      .font(.regularBody)
      .frame(width: parentWidth * 0.9)
      .overlay(alignment: .bottom) {
        GeometryReader { textField in
          Rectangle()
            .fill(Color.secondaryColor)
            .frame(width: textField.size.width + 10, height: 1, alignment: .center)
            .offset(x: -5, y: textField.size.height + 5)
        }
      }
  }
  
  @ViewBuilder
  private func makeButtons(parentWidth: CGFloat) -> some View {
    Button {
      loginViewModel.logIn(showAlert: $showingAlert, isLoggedIn: $isLoggedIn)
    } label: {
      Text("Sign In".unlocalized)
        .font(.mediumTitle3)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
    }
    .frame(width: parentWidth * 0.9, height: 60)
    .background(Color.buttonColor)
    .cornerRadius(10)
    Spacer()
    NavigationLink {
      RegisterView()
    } label: {
      CustomButtonView(text: "Sign Up".unlocalized)
        .frame(width: parentWidth * 0.9, height: 60)
        .frame(width: parentWidth * 0.9, height: 60)
    }
  }
  
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LoginView(loginViewModel: LoginViewModel(), isLoggedIn: .constant(false))
    }
    .navigationBarHidden(true)
  }
}
