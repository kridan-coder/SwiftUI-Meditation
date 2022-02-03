//
//  CardView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 16.01.2022.
//

import SwiftUI
import Kingfisher

class CardCellModel: ObservableObject, Identifiable {
  @Published var title: String
  @Published var description: String
  @Published var imageURL: URL
  
  var serverID: Int
  let id = UUID()
  
  init(serverID: Int, title: String, description: String, imageURL: URL) {
    self.title = title
    self.description = description
    self.imageURL = imageURL
    self.serverID = serverID
  }
}

struct CardCellView: View {
  @StateObject var viewModel: CardCellModel
  
  var body: some View {
    ZStack {
      Color.white
      HStack {
        VStack(alignment: .leading) {
          Text(viewModel.title)
            .lineLimit(1)
            .font(.boldTitle2)
            .foregroundColor(Color.backgroundColor)
          
          Text(viewModel.description)
            .lineLimit(2)
            .font(.mediumSubheadline)
            .foregroundColor(Color.backgroundColor)
          
          NavigationLink {} label: {
            CustomButtonView(text: "подробнее".unlocalized, backgroundColor: Color.backgroundColor, font: .regularSubheadline)
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
    .frame(idealWidth: 360, idealHeight: 175)
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    if let url = URL(string: "https://interactive-examples.mdn.mozilla.net/media/cc0-images/grapefruit-slice-332-332.jpg") {
      NavigationView {
        CardCellView(viewModel: CardCellModel(serverID: 0,
                                          title: "Заголовок блока".unlocalized,
                                          description: "Кратенькое описание блока с двумя строчками".unlocalized,
                                          imageURL: url))
      }
    }
  }
}
