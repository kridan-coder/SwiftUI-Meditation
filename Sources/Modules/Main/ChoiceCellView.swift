//
//  ChoiceCellView.swift
//  Meditation
//
import SwiftUI
import Kingfisher

struct ChoiceCellView: View {
  let model: ChoiceCellModel
  
  var body: some View {
    VStack(alignment: .center, spacing: 0) {
      Rectangle()
        .foregroundColor(Color.white)
        .cornerRadius(20)
        .frame(width: 75, height: 75)
        .overlay {
          KFImage(model.imageURL)
            .resizable()
            .scaledToFill()
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
          
        }
        .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
      
      Text(model.title)
        .foregroundColor(.white)
        .font(.regularSubheadline)
        .lineLimit(1)
        .frame(maxWidth: 95)
    }
  }
  
}

struct ChoiceCellView_Previews: PreviewProvider {
  static var previews: some View {
    if let url = URL(string: "http://mskko2021.mad.hakta.pro//uploads//feeling//Focus.png") {
      ChoiceCellView(model: ChoiceCellModel(title: "Сосредоточенным".unlocalized, imageURL: url))
        .background(Color.black)
        .frame(width: 125, height: 125)
    }
    
  }
}
