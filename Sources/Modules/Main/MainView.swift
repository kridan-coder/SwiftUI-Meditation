//
//  MainView.swift
//  Meditation
//

import SwiftUI
import Kingfisher

final class MainViewModel: ObservableObject {
  @Environment(\.appDependencies) private var dependencies
  
  @Published var nickname: String = ""
  @Published var avatarURL: String = ""
  @Published var cardModels: [CardCellViewModel] = []
  @Published var choiceModels: [ChoiceCellViewModel] = []
  
  func onAppear() {
    nickname = dependencies.userDataStorageService.nickname
    avatarURL = dependencies.userDataStorageService.avatarURL
  }
  
  init() {
    getQuotes()
    getFeelings()
  }
  
  private func getQuotes() {
    Task {
      do {
        let result = try await dependencies.quotesNetworkService.getAllQuotes()
        self.cardModels = result.data.map { CardCellViewModel(title: $0.title,
                                                              description: $0.description,
                                                              imageURL: $0.image,
                                                              serverID: $0.id) }
      } catch let error {
        log?.error(error)
      }
    }
  }
  
  private func getFeelings() {
    Task {
      do {
        let result = try await dependencies.feelingsNetworkService.getAllFeelings()
        self.choiceModels = result.data.map { ChoiceCellViewModel(title: $0.title,
                                                                  imageURL: $0.image) }
      } catch let error {
        log?.error(error)
      }
    }
  }
}

struct MainView: View {
  @ObservedObject private(set) var viewModel: MainViewModel
  
  var body: some View {
    ZStack(alignment: .top) {
      Color.backgroundColor
        .ignoresSafeArea()
      VStack(alignment: .leading) {
        makeTopBar()
        makeScrollableContent()
      }
    }
    .onAppear {
      viewModel.onAppear()
    }
    .navigationBarHidden(true)
  }
  
  @ViewBuilder
  private func makeTopBar() -> some View {
    HStack(alignment: .center) {
      Image(.hamburger)
        .resizable()
        .scaledToFit()
        .frame(width: 30, height: 30)
      
      Spacer()
      Image(.logo)
        .resizable()
        .scaledToFit()
        .frame(width: 50, height: 50)
      Spacer()
      ImageWithOptionalURL(url: viewModel.avatarURL, defaultImage: Image(.koala))
        .scaledToFit()
        .cornerRadius(20)
        .frame(width: 40, height: 40)
      
    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
  }
  
  @ViewBuilder
  private func makeScrollableContent() -> some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack(alignment: .leading) {
        Text("С возвращением, \(viewModel.nickname)!".unlocalized)
          .foregroundColor(.white)
          .font(.mediumTitle1)
          .padding(.leading).padding(.top)
        
        Text("Каким ты себя ощущаешь сегодня?".unlocalized)
          .foregroundColor(.secondaryColor)
          .font(.regularBody)
          .padding(.leading)
        
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack(alignment: .center, spacing: 0) {
            ForEach(viewModel.choiceModels) { choiceModel in
              ChoiceCellView(model: choiceModel)
            }
          }
        }
        LazyVStack(alignment: .center, spacing: 20) {
          ForEach(viewModel.cardModels) { cardModel in
            CardCellView(viewModel: cardModel)
          }
        }
        .padding(25)
        Spacer()
      }
    }
  }
  
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(viewModel: MainViewModel())
  }
}
