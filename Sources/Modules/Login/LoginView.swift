//
//  LoginScreen.swift
//  Meditation
//

import SwiftUI
import PromiseKit

final class LoginViewModel: ObservableObject {
  @Environment(\.appDependencies) private var dependencies
  
  @Binding var isLoggedIn: Bool
  @Published var shouldShowAlert: Bool = false
  @Published var alertText: String
  @Published var password: String = ""
  @Published var email: String = ""
  
  init(isLoggedIn: Binding<Bool>) {
    _isLoggedIn = isLoggedIn
    alertText = R.string.commonErrors.errorValidationText()
  }
  
  func onAppear() {
    email = dependencies.userDataStorageService.email
  }
  
  var isValidatedCorrectly: Bool {
    email.contains("@") && email.contains(".") && !password.isEmpty
  }
  
  func logIn() {
    guard isValidatedCorrectly else {
      alertText = R.string.commonErrors.errorValidationText()
      shouldShowAlert = true
      return
    }
    
    firstly {
      dependencies.authNetworkService.login(email: email, password: password)
    }.done { [self] result in
      dependencies.userDataStorageService.nickname = result.nickName
      dependencies.userDataStorageService.email = result.email
      dependencies.userDataStorageService.avatarURL = result.avatar.absoluteString
      dependencies.userDataStorageService.accessToken = result.token
      withAnimation {
        isLoggedIn = true
      }
    }.catch { error in
      log?.error(error)
      self.alertText = error.localizedDescription
      self.shouldShowAlert = true
    }
  }
  
}

struct LoginView: View {
  @ObservedObject private(set) var viewModel: LoginViewModel
  
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
    .alert(viewModel.alertText,
           isPresented: $viewModel.shouldShowAlert) {
      Button("OK".unlocalized, role: .cancel) { }
    }
  }
  
  @ViewBuilder
  private func makeFields(parentWidth: CGFloat) -> some View {
    TextField("", text: $viewModel.email)
      .placeholderShowing(when: viewModel.email.isEmpty) {
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
    SecureField("", text: $viewModel.password)
      .placeholderShowing(when: viewModel.password.isEmpty) {
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
      viewModel.logIn()
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
      Text("Sign Up".unlocalized)
        .font(.mediumTitle3)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
    }
    .frame(width: parentWidth * 0.9, height: 60)
    .background(Color.buttonColor)
    .cornerRadius(10)
  }
  
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      LoginView(viewModel: LoginViewModel(isLoggedIn: .constant(false)))
    }
    .navigationBarHidden(true)
  }
}
