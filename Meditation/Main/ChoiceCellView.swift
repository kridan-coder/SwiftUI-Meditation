//
//  ChoiceCellView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 16.01.2022.
//

import SwiftUI
import Kingfisher

struct ChoiceCellView: View {
  var model: ChoiceCellModel
  
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
        .font(.custom("Alegreya-Regular", size: 14))
        .lineLimit(1)
    }
  }
}

struct ChoiceCellView_Previews: PreviewProvider {
  static var previews: some View {
    ChoiceCellView(model: ChoiceCellModel(title: "Сосредоточенным", imageURL: URL(string: "http://mskko2021.mad.hakta.pro//uploads//feeling//Focus.png")!))
      .background(Color.black)
      .frame(width:125, height: 125)
  }
}
//
////
////  ChoiceCellView.swift
////  Meditation
////
////  Created by Daniel Krivelev on 16.01.2022.
////
//
//import SwiftUI
//import Kingfisher
//
//
//struct ChoiceCellView: View {
//  var model: ChoiceCellModel
//
//  var body: some View {
//      VStack(alignment: .center, spacing: 0) {
//        Rectangle()
//          .foregroundColor(Color.white)
//          .cornerRadius(20)
//          .frame(width: 80, height: 80)
//          .overlay {
//            KFImage(model.imageURL)
//              .resizable()
//              .scaledToFill()
//              .foregroundColor(.white)
//              .frame(width: 40, height: 40)
//              .padding(EdgeInsets(top: 15, leading: 15, bottom: 5, trailing: 15))
//          }
//
//
//        Text(model.title)
//          .foregroundColor(.white)
//          .font(.custom("Alegreya-Regular", size: 14))
//          .lineLimit(1)
//      }
//      .frame(width: 120)
//
//
//
//  }
//}
//
//struct ChoiceCellView_Previews: PreviewProvider {
//  static var previews: some View {
//    ChoiceCellView(model: ChoiceCellModel(title: "Сосредоточенным", imageURL: URL(string: "http://mskko2021.mad.hakta.pro//uploads//feeling//Focus.png")!))
//      .background(Color.black)
//      //.frame(width:125, height: 125)
//  }
//}
//
