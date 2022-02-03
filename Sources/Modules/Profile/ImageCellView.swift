//
//  ImageView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 19.01.2022.
//

import SwiftUI
import Kingfisher

class ImageCellModel: ObservableObject, Identifiable {
  @Published var date: String
  let id = UUID()
  var image: Image
  
  init(date: String, image: Image) {
    self.image = image
    self.date = date
  }
}

struct ImageCellView: View {
  var isNavigationBarHidden = true
  
  @StateObject var viewModel: ImageCellModel
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      viewModel.image
        .resizable()
        .cornerRadius(20)
      
      Text(viewModel.date)
        .font(.mediumBody)
        .foregroundColor(.white)
        .offset(x: 15, y: -15)
    }
    .aspectRatio(1.3, contentMode: .fit)
    .padding(8)
  }
}

struct ImageView_Previews: PreviewProvider {
  static var previews: some View {
    ImageCellView(viewModel: ImageCellModel(date: "11:00".unlocalized,
                                            image: Image(.people)))
  }
}
