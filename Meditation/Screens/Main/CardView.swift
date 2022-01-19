//
//  CardView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 16.01.2022.
//

import SwiftUI
import Kingfisher

class CardViewModel: ObservableObject, Identifiable {
  @Published var title: String
  @Published var description: String
  @Published var imageURL: URL
  
  var id: Int
  
  init(id: Int, title: String, description: String, imageURL: URL) {
    self.title = title
    self.description = description
    self.imageURL = imageURL
    self.id = id
  }
}

struct CardView: View {
  
  @StateObject var viewModel: CardViewModel
  
  var body: some View {
    
    GeometryReader { screen in
      ZStack {
        Color.white
        
        HStack {
          VStack(alignment: .leading) {
            Text(viewModel.title)
              .lineLimit(1)
              .font(.custom("Alegreya-Bold", size: 26))
              .foregroundColor(Color("BackgroundColor"))
            
            Text(viewModel.description)
              .lineLimit(2)
              .font(.custom("Alegreya-Medium", size: 16))
              .foregroundColor(Color("BackgroundColor"))
            
            NavigationLink {
              
            } label: {
              CustomButtonView(text: "подробнее", backgroundColor: Color("BackgroundColor"), font: .custom("Alegreya-Regular", size: 16))
            }
            .frame(width: 150, height: 40)
            
          }
          .padding()
          KFImage(viewModel.imageURL)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .padding(.trailing)
        }
        
      }
      .cornerRadius(15)
    
      
    }
    .frame(idealWidth: 360, idealHeight: 175)
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      CardView(viewModel: CardViewModel(id: 0, title: "Заголовок блока", description: "Кратенькое описание блока с двумя строчками", imageURL: URL(string: "https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg")!))
    }
    
  }
}

