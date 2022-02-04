//
//  ImageAddView.swift
//  Meditation
//

import SwiftUI

struct ImageCellAddView: View {
  var body: some View {
    ZStack {
      Color.addColor
        .ignoresSafeArea()
      Text("+")
        .foregroundColor(.white)
        .fontWeight(.medium)
        .font(.system(size: 50))
    }
    .cornerRadius(20)
    .aspectRatio(1.3, contentMode: .fit)
    .padding(8)
  }
  
}

struct ImageAddView_Previews: PreviewProvider {
  static var previews: some View {
    ImageCellAddView()
  }
}
