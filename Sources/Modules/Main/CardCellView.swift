//
//  CardView.swift
//  Meditation
//

import SwiftUI
import Kingfisher

final class CardCellViewModel: ObservableObject, Identifiable {
  @Published var title: String
  @Published var description: String
  @Published var imageURL: URL
  
  let serverID: Int
  let id = UUID()
  
  init(title: String,
       description: String,
       imageURL: URL,
       serverID: Int) {
    self.title = title
    self.description = description
    self.imageURL = imageURL
    self.serverID = serverID
  }
}

struct CardCellView: View {
  let viewModel: CardCellViewModel
  
  @State private var selected: Bool? = false
  
  var body: some View {
    NavigationLink(destination: EmptyView(),
                   tag: true,
                   selection: $selected) { EmptyView() }
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
          
          Button("подробнее") {
            selected?.toggle()
          }
          .buttonStyle(CustomButtonStyle(backgroundColor: .backgroundColor,
                                         font: .regularSubheadline))
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
        CardCellView(viewModel: CardCellViewModel(title: "Заголовок блока".unlocalized,
                                                  description: "Кратенькое описание блока с двумя строчками".unlocalized,
                                                  imageURL: url,
                                                  serverID: 0))
      }
    }
  }
}
