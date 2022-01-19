//
//  MainView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 16.01.2022.
//

import SwiftUI
import Kingfisher

class MainViewModel: ObservableObject {
  @AppStorage("nickName") var nickname: String = "Эмиль"
  @AppStorage("avatar") var avatarLink: String = ""
  
  @Published var choiceCellModels: [ChoiceCellModel] =
  [
  ]
  @Published var cardCellModels: [CardViewModel] = [
  ]
  
  init() {
    APIClient().getQuotes { quotes in
      self.cardCellModels = []
      for quote in quotes.data {
        self.cardCellModels.append(CardViewModel(id: quote.id, title: quote.title, description: quote.description, imageURL: quote.image))
      }
    }
    
    APIClient().getFeelings { feelings in
      self.choiceCellModels = []
      let sorted = feelings.data.sorted { $0.position < $1.position
      }
      
      for feeling in sorted {
        self.choiceCellModels.append(ChoiceCellModel(title: feeling.title, imageURL: feeling.image))
      }

    }
  }
  
}

struct MainView: View {
  @StateObject var viewModel = MainViewModel()
  
  var body: some View {
    
    
    ZStack(alignment: .top) {
      Color("BackgroundColor")
        .ignoresSafeArea()
      
      VStack(alignment: .leading) {
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
          if let url = URL(string: viewModel.avatarLink) {
            KFImage(url)
              .resizable()
              .scaledToFit()
              .cornerRadius(20)
              .frame(width:40, height: 40)
          } else {
            Image("Koala")
              .resizable()
              .scaledToFit()
              .cornerRadius(20)
              .frame(width:40, height: 40)
          }
          
        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        
        ScrollView(.vertical, showsIndicators: false) {
          VStack(alignment: .leading) {
            Text("С возвращением, \(viewModel.nickname)!")
              .foregroundColor(.white)
              .font(.custom("Alegreya-Medium", size: 28))
              .padding(.leading).padding(.top)
            
            Text("Каким ты себя ощущаешь сегодня?")
              .foregroundColor(Color("SecondaryColor"))
              .font(.custom("Alegreya", size: 19))
              .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
              LazyHStack(alignment: .center, spacing: 0) {
                ForEach(viewModel.choiceCellModels) { choiceModel in
                  ChoiceCellView(model: choiceModel)
                }
              }
            }
            LazyVStack(alignment: .center, spacing: 20) {
              ForEach(viewModel.cardCellModels) { cardModel in
                CardView(viewModel: cardModel)
              }
            }
            .padding(25)
            Spacer()
          }
        }
      }
    }
    .navigationBarHidden(true)
  }
  
  
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}

