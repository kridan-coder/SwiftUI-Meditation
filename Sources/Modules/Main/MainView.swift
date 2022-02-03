//
//  MainView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 16.01.2022.
//

import SwiftUI
import Kingfisher
import PromiseKit

class MainViewModel: ObservableObject {
  @Environment(\.appDependencies) private var dependencies
  
  @Published var nickname: String = ""
  @Published var avatarURL: String = ""
  @Published var cardModels: [CardCellModel] = []
  @Published var choiceModels: [ChoiceCellModel] = []
  
  func onAppear() {
    nickname = dependencies.userDataStorageService.nickname ?? ""
    avatarURL = dependencies.userDataStorageService.avatarURL ?? ""
  }
  
  init() {
    getQuotes()
    getFeelings()
  }
  
  private func getQuotes() {
    firstly {
      dependencies.quotesNetworkService.getAllQuotes()
    }.done { result in
      let quotes = result.data.map { CardCellModel(serverID: $0.id,
                                                   title: $0.title,
                                                   description: $0.description,
                                                   imageURL: $0.image) }
      for quote in quotes {
        self.cardModels.append(quote)
      }
    }.catch { error in
      log?.error(error)
    }
  }
  
  private func getFeelings() {
    firstly {
      dependencies.feelingsNetworkService.getAllFeelings()
    }.done { result in
      let feelings = result.data.map { ChoiceCellModel(title: $0.title,
                                                       imageURL: $0.image) }
      for feeling in feelings {
        self.choiceModels.append(feeling)
      }
    }.catch { error in
      log?.error(error)
    }
  }
  
}

struct MainView: View {
  @ObservedObject var viewModel: MainViewModel
  
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
      if let url = URL(string: viewModel.avatarURL) {
        KFImage(url)
          .resizable()
          .scaledToFit()
          .cornerRadius(20)
          .frame(width: 40, height: 40)
      } else {
        Image(.koala)
          .resizable()
          .scaledToFit()
          .cornerRadius(20)
          .frame(width: 40, height: 40)
      }
      
    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
  }
  
  @ViewBuilder
  private func makeScrollableContent() -> some View {
    ScrollView(.vertical, showsIndicators: false) {
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
            CardView(viewModel: cardModel)
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
