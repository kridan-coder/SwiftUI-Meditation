//
//  ImageView.swift
//  Meditation
//

import SwiftUI
import Kingfisher

struct ImageCellView: View {
  var model: ImageCellModel
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      model.image
        .resizable()
        .cornerRadius(20)
      
      Text(model.date)
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
    ImageCellView(model: ImageCellModel(date: "11:00".unlocalized,
                                        image: Image(.people)))
  }
}
