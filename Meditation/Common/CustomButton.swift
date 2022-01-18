//
//  CustomButton.swift
//  Meditation
//
//  Created by Developer on 12.01.2022.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .font(.custom("Alegreya-Medium", size: 25))
      .background(Color("ButtonColor"))
      .cornerRadius(10)
  }
}


struct CustomButtonView: View {
  var text: String
  var textColor: Color = .white
  var backgroundColor: Color = Color("ButtonColor")
  var cornerRadius: CGFloat = 10
  var font: Font = .custom("Alegreya-Medium", size: 25)
  var body: some View {
    GeometryReader { view in
      Text(text)
        .foregroundColor(textColor)
        .font(font)
        .frame(width: view.size.width, height: view.size.height)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
    }
  }
}

struct CustomButton_Previews: PreviewProvider {
  static var previews: some View {
    CustomButtonView(text: "Press!")
      .frame(width: 200, height: 50)
  }
}
