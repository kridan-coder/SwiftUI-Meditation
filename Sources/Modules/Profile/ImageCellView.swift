//
//  ImageView.swift
//  Meditation
//

import SwiftUI
import Kingfisher

final class ImageCellViewModel: ObservableObject {
  @Published var date: String
  @Published var image: Image
  
  init(date: String, image: Image) {
    self.date = date
    self.image = image
  }
}

struct ImageCellView: View {
  var viewModel: ImageCellViewModel
  
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
    ImageCellView(viewModel: ImageCellViewModel(date: "11:00".unlocalized,
                                            image: Image(.people)))
  }
}
